package com.game.protect.view
{
    import com.*;
    import com.f1.utils.cue.*;
    import com.game.guide.control.*;
    import com.game.protect.control.*;
    import flash.events.*;

    public class ProtectServerIcon extends ServerHitIcon
    {

        public function ProtectServerIcon()
        {
            super("expireServerIcon");
            type = "ProtectServerIcon";
            _content.gotoAndStop(1);
            addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            ButtonFlickerControl.getInstance().addButtonFlicker(this);
            return;
        }// end function

        public function show() : void
        {
            if (!stage)
            {
                Global.popManager.addedServerToCue(this);
            }
            return;
        }// end function

        public function hide() : void
        {
            if (stage)
            {
                Global.popManager.removeServerToCue(this);
            }
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            ProtectControl.getInstance().openCreatePasswordRemindPanel();
            ButtonFlickerControl.getInstance().removeButtonFlicker(this);
            return;
        }// end function

        private function onOut(event:MouseEvent) : void
        {
            _content.gotoAndStop(1);
            return;
        }// end function

        private function onOver(event:MouseEvent) : void
        {
            _content.gotoAndStop(2);
            return;
        }// end function

    }
}
