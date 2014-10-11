package com.game.movie
{
    import com.events.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SpeakBox2 extends Component
    {
        private var _direction:String;
        private var skin:String;
        private var nameColor:uint;
        private var mc_head:MovieClip;
        public var txt_name:TextField;
        public var txt_content:TextField;
        public var img:Image;
        public var isOpen:Boolean;

        public function SpeakBox2(param1:String = "right")
        {
            this._direction = param1;
            this.skin = param1 == "left" ? ("LeftDialogSkin") : ("RightDialogSkin");
            this.nameColor = param1 == "left" ? (13421568) : (16635261);
            display = ToolKit.getNew(this.skin);
            if (display)
            {
                this.init();
                addChildAt(display, 0);
            }
            else
            {
                loadDisplay("res/dialog.swf");
            }
            return;
        }// end function

        public function direction() : String
        {
            return this._direction;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI(this.skin);
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this.mc_head = display.getChildByName("mc_head") as MovieClip;
            this.txt_name = display.getChildByName("txt_name") as TextField;
            this.txt_name.defaultTextFormat = new TextFormat(null, 12, 13421568, true);
            this.txt_content = display.getChildByName("txt_content") as TextField;
            this.img = new Image();
            this.mc_head.addChild(this.img);
            this.addEventListener(MouseEvent.CLICK, this.close);
            return;
        }// end function

        public function close(event:MouseEvent = null) : void
        {
            visible = false;
            this.isOpen = false;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = Params.ROLE_HEAD_PATH + param1.url + ".png";
            this.setHeadPic(_loc_2);
            this.setRoleName(param1.name);
            this.setText(param1.content);
            return;
        }// end function

        public function setHeadPic(param1:String) : void
        {
            if (this.img && param1)
            {
                this.img.load(param1);
            }
            return;
        }// end function

        public function setRoleName(param1:String) : void
        {
            if (this.txt_name && param1)
            {
                this.txt_name.text = param1;
            }
            return;
        }// end function

        public function setText(param1:String) : void
        {
            if (this.txt_content && param1)
            {
                this.txt_content.text = param1;
            }
            TweenLite.delayedCall(2.5, this.speekOver);
            return;
        }// end function

        private function speekOver() : void
        {
            this.dispatchEvent(new TalkBoxEvent(TalkBoxEvent.SPEAK_OVER));
            return;
        }// end function

        public function open() : void
        {
            visible = true;
            this.isOpen = true;
            return;
        }// end function

    }
}
