package com.game.mail.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.guide.control.*;
    import com.game.mail.bean.*;
    import com.game.mail.control.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class MailServerIcon extends ServerHitIcon
    {
        private var _back:Sprite;
        private var back:MovieClip;
        private var _onekey:OneKeyReceive;
        private var countBack:Sprite;
        private var _mail:MailSummaryInfo;

        public function MailServerIcon(param1:String)
        {
            super("mailservericon");
            this._back = _content.getChildByName("countBack") as Sprite;
            this.type = param1;
            _content.gotoAndStop(1);
            this.setWH(_content.width, _content.height);
            addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            this._onekey = new OneKeyReceive();
            this._onekey.clickFun = this.onekeyClick;
            _content.addEventListener(MouseEvent.CLICK, this.__mouseClick);
            ButtonFlickerControl.getInstance().addButtonFlicker(this);
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            return;
        }// end function

        public function get mail() : MailSummaryInfo
        {
            return this._mail;
        }// end function

        public function set mail(param1:MailSummaryInfo) : void
        {
            this._mail = param1;
            return;
        }// end function

        private function onekeyClick() : void
        {
            var _loc_1:* = Global.popManager.getServerToCue("mailservericon");
            if (_loc_1 != null)
            {
                MailController.getInstance().onekeyDropPoint = _loc_1.localToGlobal(new Point(_loc_1.width * 0.5, _loc_1.height * 0.5));
            }
            MailController.getInstance().getNextItem();
            return;
        }// end function

        override public function set type(param1:String) : void
        {
            _type = param1;
            return;
        }// end function

        override public function set count(param1:int) : void
        {
            _count = param1 > 99 ? (99) : (param1);
            if (param1 != 1)
            {
                this._back.visible = true;
                _txtCount.text = _count.toString();
            }
            else
            {
                this._back.visible = false;
                _txtCount.text = "";
            }
            this.tipsStr = this.getTipsStr(info);
            return;
        }// end function

        private function getTipsStr(param1:Object) : String
        {
            var _loc_2:* = null;
            _loc_2 = LanguageCfgObj.getInstance().getByIndex("10914");
            return _loc_2;
        }// end function

        protected function __mouseClick(event:MouseEvent) : void
        {
            MailController.getInstance().openMailUnread();
            ToolKit.disappear(this._onekey);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this);
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            ToolKit.disappear(this._onekey);
            _content.gotoAndStop(1);
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            if (count >= 5)
            {
                this._onekey.move(52, 2);
                addChild(this._onekey);
            }
            _content.gotoAndStop(2);
            return;
        }// end function

    }
}
