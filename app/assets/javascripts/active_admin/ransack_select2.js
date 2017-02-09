//= require select2
//= require_self

$(function() {
  setupSelect2(document);

  $(document).on('has_many_add:after', function(event, container){
    setupSelect2(container);
  });

  function setupSelect2(container) {
    var DEFAULT_SELECT_WIDTH = '80%';

    $('.select2-ransack-ajax', container).each(function(i, el) {
      var url = $(el).data('url');
      var field = $(el).data('field');
      var displayName = $(el).data('display_name');
      var width = $(el).data('width') || DEFAULT_SELECT_WIDTH;
      var model = $(el).data('model');
      var responseRoot = $(el).data('response_root');
      var minimumInputLength = $(el).data('minimum_input_length');
      var selectInstance;

      var ajaxOptions = {
        url: url,
        dataType: 'json',
        delay: 250,
        data: function(term) {
          var query = { q: { } };
          query['q'][field] = term;
          return query;
        },
        results: function(data, page) {
          if(data.constructor == Object) {
            data = data[responseRoot];
          }

          return {
            results: jQuery.map(data, function(resource) {
              return {
                id: resource.id,
                text: resource[displayName].toString()
              };
            })
          };
        },
        cache: true
      };

      var select2Config = {
        width: width,
        containerCssClass: 'nested-select-container',
        minimumInputLength: minimumInputLength,
        initSelection: function(element, callback) {
          var id = $(element).val();
          var text = $(element).data('selected') || '';
          $(element).data('selected', '');

          callback({
            id: id,
            text: text
          });
        }
      };

      select2Config.ajax = ajaxOptions;
      selectInstance = $(el).select2(select2Config);
    });
  }
});