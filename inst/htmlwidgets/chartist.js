HTMLWidgets.widget({

  name: 'chartist',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {
    
    console.log(x);
    
    new Chartist.Line('#' + el.id, x.data, x.options);

  },

  resize: function(el, width, height, instance) {

  }

});
