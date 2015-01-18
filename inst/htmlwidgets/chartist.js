HTMLWidgets.widget({

  name: 'chartist',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {
    
    switch(x.type) {
      case "Line":
        new Chartist.Line('#' + el.id, x.data, x.options);
        break;
      case "Bar":
        new Chartist.Bar('#' + el.id, x.data, x.options);
        break;
      default:
        console.log("No type muched");
        // debug
        console.log(x);
    }

  },

  resize: function(el, width, height, instance) {

  }

});
