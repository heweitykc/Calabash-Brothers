package com.game.expireguide.view
{
    import com.*;
    import com.f1.utils.cue.*;
    import com.game.expireguide.control.*;
    import com.game.guide.control.*;
    import flash.events.*;

    public class ExpireServerIcon extends ServerHitIcon
    {

        public function ExpireServerIcon(param1:String)
        {
            super("expireServerIcon");
            this.type = "expireServerIcon";
            _content.gotoAndStop(1);
            addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            ButtonFlickerControl.getInstance().addButtonFlicker(this);
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            ExpireGuideControl.getInstance().showByEquipInfo(info);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this);
            finalize();
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
