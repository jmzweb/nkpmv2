jQuery(function () {
    $('.subbtns').find('a').eq(0).addClass('select');
    ResizeRight();
    $('.subbtns').find('a').each(function (index, e) {
        $(e).click(function () {
            var temp = $('.subbtns').find('a');
            for (var i = 0; i < temp.length; i++) {
                if (i == index) {
                    if (!$(e).hasClass('select'))
                        $(e).addClass('select');
                    $('.tabbox').find('.tabitem').eq(i).show();
                } else {
                    if (temp.eq(i).hasClass('select'))
                        temp.eq(i).removeClass('select');
                    $('.tabbox').find('.tabitem').eq(i).hide();
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