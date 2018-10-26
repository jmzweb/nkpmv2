jQuery(function () {
    $('.content-wrap').css('height', $(window).height() - $('.new-sidebar-box').height());
    $('.sidebar').find('li').eq(0).addClass('sidebar-current');
   
});

//关闭窗口
function _appClose() {
    if (!!frameElement) {
        if (!!frameElement.lhgDG)
            frameElement.lhgDG.cancel();
        else {
            if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
                window.parent.CloseLayer();
            } else if (window.parent.parent.CloseLayer) {
                window.parent.parent.CloseLayer();
            }
        }
        window.close();
    }
    else {
        if (window.parent.CloseLayer) {//20170921 by zjs 多页签页面的级别是三级 所以如果parent不行 就行parent.parent
            window.parent.CloseLayer();
        } else if (window.parent.parent.CloseLayer) {
            window.parent.parent.CloseLayer();
        }
        // window.close();
    }
}