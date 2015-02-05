HTMLWidgets.widget({

  name: 'chartist',

  type: 'output',

  initialize: function(el, width, height) {
    
    if(!window.__charts) {
      window.__charts = [];
    }
    
    return {
    };

  },
  
  replayAnimation: function(charts, interval){
    
    var replayFnc = function(){
      for(var i = 0; i < charts.length; i++) {
        charts[i].__seq = 0;
        charts[i].update();
      }
    };
    
    if(window.__AnimateInterval) {
      clearInterval(window.__AnimateInterval);
      window.__AnimateInterval = null;
    }
    window.__AnimateInterval = setInterval(replayFnc, interval);
  },

  renderValue: function(el, x, instance) {
    var chart;
        
    switch(x.type) {
      case 'Line':
        chart = new Chartist.Line('#' + el.id, x.data, x.options);
        break;
      case 'Bar':
        chart = new Chartist.Bar('#' + el.id, x.data, x.options);
        break;
      case 'Pie':
        //only use first data series
        var data = Chartist.extend({}, x.data);
        data.series = data.series[0];
        chart = new Chartist.Pie('#' + el.id, data, x.options);
        break;
      default:
        console.log('No type matched');
    }
    
    window.__charts.push(chart);
    
    if(x.hasOwnProperty('svg_animate')) {
      
      chart.__seq = 0;
      
      var targets = ['label', 'grid', 'point', 'line', 'bar', 'slice'];
      var styles  = ['x', 'x1', 'x2', 'y', 'y1', 'y2', 'opacity'];
      var target = '', style = '';
      
      for(var i = 0; i < targets.length; i++) {
        target = targets[i];
        if(!x.svg_animate[target]) continue;
        
        for(var j = 0; j < styles.length; j++) {
          style = styles[j];
          if(!x.svg_animate[target][style]) continue;
          
          chart.on('draw', this.constructSvgFnc(x.svg_animate[target][style], target, style, chart));
          
          this.replayAnimation(window.__charts, interval = x.svg_animate[target][style].interval);
        }
      }
    }
  },

  resize: function(el, width, height, instance) {

  },
  
  constructSvgFnc: function(params, target, style, chart){
    
    var is_relative = params.relative;
    var is_opacity  = (style == 'opacity');
    
    var accessor_map = {
      label: {x: 'x', y: 'y', width: 'width', height: 'height'},
      grid:  {x1: 'x1', x2: 'x2', y1: 'y1', y2: 'y2'},
      point: {x1: 'x',  x2: 'x',  y1: 'y',  y2: 'y'},
      line:  {},
      bar:   {x1: 'x',  x2: 'x',  y1: 'y1',  y2: 'y2'},
      slice: {}
    }
    
    var accessor = accessor_map[target][style];
          
    return function (data) {
      var params_constructed = {};
      
      if (!target || data.type == target) {
        chart.__seq++;
        params_constructed[style] = {
                  dur:  params.dur,
                  begin: chart.__seq * params.delay,
                  from: (accessor ? data[accessor] : null) + params.offset,
                  // opacity will be 1 at the end of animation
                  to:   (accessor ? data[accessor] : 1),
                  easing: params.easing
              };
        data.element.animate(params_constructed);
      }
    };
  }

});
