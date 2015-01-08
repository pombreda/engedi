// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require bootbox
//= require nprogress
//= require gritter
//= require ckeditor/init
//= require jquery.validate.js
//= require additional-methods.min.js
//= require jquery.gritter
//= require bootstrap3-wysihtml5.all.min.js
//= require jquery.datatables.min.js
//= require datatables.js
//= require highcharts
//= require select2
//= require timetable
//= require Theme

//= require turbolinks

//= require_self

(function ($) {

    $(document).on('page:fetch', function () {
        NProgress.start();
    });
    $(document).on('page:change', function () {
        NProgress.done();
    });
    $(document).on('page:restore', function () {
        NProgress.remove();
    });

    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    $(function () {

        function init() {

            Theme.init();

            if ($('.form-validate').length) {
                $('.form-validate').on('submit', function () {
                    for (var i in CKEDITOR.instances) {
                        CKEDITOR.instances[i].updateElement();
                    }
                });

                $('.form-validate').each(function () {
                    $(this).validate({
                        ignore: ":hidden:not(textarea)",
                        rules: {
                            WysiHtmlField: "required"
                        },
                        errorPlacement: function (error, element) {
                            error.appendTo(element.closest("div[class*=col]"));
                        }
                    });
                })
            }

            if ($('table.dataTable').length) {
                $('table.dataTable').each(function(){
                    var bFilter = true;
                    if($(this).hasClass('nofilter')){
                        bFilter = false;
                    }
                    var columnSort = [];
                    $(this).find('thead tr td').each(function(){
                        if($(this).attr('data-bSortable') && $(this).attr('data-bSortable') == 'false') {
                            columnSort.push({ "bSortable": false });
                        } else {
                            columnSort.push({ "bSortable": true });
                        }
                    });
                    $(this).dataTable({
                        "sPaginationType": "full_numbers",
                        "bFilter": bFilter,
                        "fnDrawCallback": function( oSettings ) {
                        },
                        "aoColumns": columnSort
                    });
                });
            }
        }

        $.rails.allowAction = function (element) {
            var message = element.data('confirm'),
                answer = false, callback;
            if (!message) {
                return true;
            }

            if ($.rails.fire(element, 'confirm')) {
                myCustomConfirmBox(message, function () {
                    callback = $.rails.fire(element,
                        'confirm:complete', [answer]);
                    if (callback) {
                        var oldAllowAction = $.rails.allowAction;
                        $.rails.allowAction = function () {
                            return true;
                        };
                        element.trigger('click');
                        $.rails.allowAction = oldAllowAction;
                    }
                });
            }
            return false;
        };

        function myCustomConfirmBox(message, callback) {
            bootbox.confirm(message, function (confirmed) {
                if (confirmed) {
                    callback();
                }
            });
        }

        window['rangy'].initialized = false;

        init();

    });
})(jQuery);
