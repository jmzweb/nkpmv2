jQuery(function () {
    var $nav = $('.nav'),
		$cur = $('.nav li.current a'),
		$navLine = $('.nav-line'),
		$anchor = $('a', $nav.children()),
		curPosL = $cur.position().left,
		curW = $cur.outerWidth(true),
		curIdx = $('li.current', $nav).index();
    $navLine.css({ 'width': curW, 'left': curPosL });
    $anchor.not('li.last a', $nav).each(function (index) {
        var posL = $(this).position().left,
			w = $(this).outerWidth(true);
        $(this).mouseenter(function () {
            $navLine.animate({ 'width': w, 'left': posL }, 150);
            $(this).parent().addClass('current').siblings().removeClass('current');
        });
    });
    $nav.mouseleave(function () {
        $navLine.animate({ 'width': curW, 'left': curPosL }, 150);
        $anchor.parent(':eq(' + curIdx + ')').addClass('current').siblings().removeClass('current');
    });
});