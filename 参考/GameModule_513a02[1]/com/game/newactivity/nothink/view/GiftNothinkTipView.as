package com.game.newactivity.nothink.view
{
    import com.view.tipcell.*;

    public class GiftNothinkTipView extends BaseTips
    {
        private static var _giftNothinkContent:GiftNothinkContent;

        public function GiftNothinkTipView()
        {
            if (!_giftNothinkContent)
            {
                _giftNothinkContent = new GiftNothinkContent();
            }
            addChild(_giftNothinkContent);
            return;
        }// end function

    }
}
