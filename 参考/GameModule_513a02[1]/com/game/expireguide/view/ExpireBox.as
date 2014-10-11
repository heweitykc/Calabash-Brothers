package com.game.expireguide.view
{
    import com.f1.ui.box.*;
    import com.game.map.control.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class ExpireBox extends SysCueBox
    {
        private var _img:IconItem;

        public function ExpireBox(param1 = null)
        {
            super(param1);
            this._img = new IconItem();
            this._img.x = 12;
            this._img.y = 60;
            addChild(this._img);
            this._img.image.x = 5;
            this._img.image.y = 5;
            this._img.setImageSize(56, 56);
            if (txt)
            {
                txt.text = "";
            }
            txt = new TextField();
            txt.width = 222;
            txt.height = 64;
            txt.x = 90;
            txt.y = 50;
            txt.autoSize = TextFieldAutoSize.LEFT;
            txt.multiline = true;
            txt.wordWrap = true;
            txt.filters = [BLACK_FILTER];
            txt.addEventListener(TextEvent.LINK, this.onLinkHandler);
            txt.autoSize = TextFieldAutoSize.LEFT;
            addChild(txt);
            return;
        }// end function

        public function setInfo(param1:PropInfo) : void
        {
            this._img.setInfo(param1);
            return;
        }// end function

        private function onLinkHandler(event:TextEvent) : void
        {
            MapControl.getInstance().showFreshManCard();
            return;
        }// end function

    }
}
