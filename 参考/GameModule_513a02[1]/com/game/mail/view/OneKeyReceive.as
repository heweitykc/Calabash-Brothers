package com.game.mail.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.events.*;

    public class OneKeyReceive extends Component
    {
        private var _bg:Sprite;
        private var _btn:BaseButton;
        private var _clickFun:Function;

        public function OneKeyReceive()
        {
            super("onekey_receive");
            this._bg = getDisplayChildByName("bg");
            this._btn = new BaseButton(getDisplayChildByName("btn_receive"));
            this._btn.setText(LanguageCfgObj.getInstance().getByIndex("10915"));
            this._btn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        public function get clickFun() : Function
        {
            return this._clickFun;
        }// end function

        public function set clickFun(param1:Function) : void
        {
            this._clickFun = param1;
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            if (this._clickFun != null)
            {
                this._clickFun();
            }
            return;
        }// end function

    }
}
