package com.game.protect.view
{
    import com.f1.ui.*;
    import flash.display.*;
    import flash.text.*;

    public class ProtectEditFieldStateView extends Component
    {
        private var viewOk:DisplayObject;
        private var viewBad:TextField;
        private var state:uint;
        public static var STATE_NONE:uint = 1;
        public static var STATE_OK:uint = 2;
        public static var STATE_BAD:uint = 3;

        public function ProtectEditFieldStateView(param1:Sprite, param2:String = null)
        {
            super(param1);
            this.viewOk = getDisplayChildByName("viewOk");
            this.viewBad = getDisplayChildByName("viewBad");
            this.viewBad.autoSize = TextFieldAutoSize.LEFT;
            this.state = STATE_NONE;
            this.viewOk.visible = false;
            this.viewBad.visible = false;
            if (param2 != null)
            {
                this.setBadText(param2);
            }
            return;
        }// end function

        public function setState(param1:uint) : void
        {
            if (this.state != param1)
            {
                this.state = param1;
                this.viewOk.visible = this.state == STATE_OK;
                this.viewBad.visible = this.state == STATE_BAD;
            }
            return;
        }// end function

        public function setOk(param1:Boolean, param2:Boolean = true) : void
        {
            this.setState(param1 ? (STATE_OK) : (param2 ? (STATE_BAD) : (STATE_NONE)));
            return;
        }// end function

        public function clearState() : void
        {
            this.setState(STATE_NONE);
            return;
        }// end function

        public function setBadText(param1:String) : void
        {
            this.viewBad.text = param1;
            return;
        }// end function

    }
}
