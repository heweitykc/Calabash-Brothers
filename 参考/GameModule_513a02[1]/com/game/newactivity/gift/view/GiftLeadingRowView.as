package com.game.newactivity.gift.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;

    public class GiftLeadingRowView extends Component
    {
        private var button:BaseButton;
        private var panel:GiftPanel;
        public static var HEIGHT:int = 253;

        public function GiftLeadingRowView(param1:GiftPanel)
        {
            super(param1.leadingRowResourceClassName);
            this.panel = param1;
            this.button = UiUtil.createButton(this, "button", this.onButtonClick);
            var _loc_2:* = getDisplayChildByName("buttonEffect");
            if (_loc_2)
            {
                var _loc_3:* = false;
                _loc_2.mouseEnabled = false;
                _loc_2.mouseChildren = _loc_3;
            }
            return;
        }// end function

        private function onButtonClick(event:MouseEvent) : void
        {
            this.panel.onLeadingRowClick();
            return;
        }// end function

    }
}
