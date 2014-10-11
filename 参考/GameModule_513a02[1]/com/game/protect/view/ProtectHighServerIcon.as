package com.game.protect.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.guide.control.*;
    import flash.display.*;
    import flash.events.*;

    public class ProtectHighServerIcon extends ServerHitIcon
    {
        private var back:MovieClip;
        private var countBack:Sprite;

        public function ProtectHighServerIcon()
        {
            super("guildDelateServerIcon");
            _content.gotoAndStop(1);
            addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            _content.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            ButtonFlickerControl.getInstance().addButtonFlicker(this);
            return;
        }// end function

        override protected function getComp() : void
        {
            super.getComp();
            this.back = _content.getChildByName("back") as MovieClip;
            this.countBack = _content.getChildByName("countBack") as Sprite;
            return;
        }// end function

        override public function set count(param1:int) : void
        {
            _count = param1;
            _txtCount.text = param1.toString();
            if (param1 > 1)
            {
                _txtCount.visible = true;
            }
            else
            {
                _txtCount.visible = false;
            }
            this.tipsStr = this.getTipsStr();
            return;
        }// end function

        private function getTipsStr() : String
        {
            var _loc_1:* = null;
            _loc_1 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10007", "lang_highlock"), [_count]);
            return _loc_1;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this);
            var _loc_2:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10008", "lang_highlock"), [_count]);
            Global.popManager.cue(_loc_2, LanguageCfgObj.getInstance().getByIndex("10004", "lang_highlock"), null, null, null, 1, LanguageCfgObj.getInstance().getByIndex("10638"));
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
