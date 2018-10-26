jQuery(function () {
    $('.content-wrap').css('height', $('.main-area').height()-3);
    $('.sidebar').find('li').eq(0).addClass('sidebar-current');
   
    $('.sidebar').find('li').each(function (index, e) {
        $(e).click(function () {
            var temp = $('.sidebar').find('li');
            for (var i = 0; i < temp.length; i++) {
                if (i == index) {
                    if (!$(e).hasClass('sidebar-current'))
                        $(e).addClass('sidebar-current');
                   
                } else {
                    if (temp.eq(i).hasClass('sidebar-current'))
                        temp.eq(i).removeClass('sidebar-current');
                    
                }
            }


        });
    });
});
function ResizeRight() {
    var leftPanel = parseFloat($('.subbtns').width()) + parseFloat($('.subbtns').css('left').replace('px', ''));
    $('.tabright').css('margin-left', leftPanel + 'px')

    $('.tabbox').height(parent.$('body').height());
}