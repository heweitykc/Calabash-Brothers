package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.cue.*;
    import com.game.guide.control.*;
    import com.game.guild.control.*;
    import com.model.*;
    import flash.events.*;

    public class GuildDelateServerIcon extends ServerHitIcon
    {

        public function GuildDelateServerIcon(param1:String = "guildDelateServerIcon")
        {
            super(param1);
            this.type = param1;
            _content.gotoAndStop(1);
            this.tipsStr = this.getTipsStr(info);
            this.setWH(_content.width, _content.height);
            addEventListener(MouseEvent.ROLL_OVER, this.onOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onOut);
            _content.addEventListener(MouseEvent.CLICK, this.__mouseClick);
            ButtonFlickerControl.getInstance().addButtonFlicker(this);
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            return;
        }// end function

        override public function set type(param1:String) : void
        {
            _type = param1;
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

        private function getTipsStr(param1:Object) : String
        {
            var _loc_2:* = null;
            _loc_2 = LanguageCfgObj.getInstance().getByIndex("12421");
            return _loc_2;
        }// end function

        protected function __mouseClick(event:MouseEvent) : void
        {
            var event:* = event;
            var str:* = LanguageCfgObj.getInstance().getByIndex("12420");
            Global.popManager.cue(str, LanguageCfgObj.getInstance().getByIndex("12422"), null, function () : void
            {
                if (UserObj.getInstance().playerInfo.guildId)
                {
                    GuildControl.getInstance().openGuildBox();
                    if (GuildControl.getInstance().guildBox.btn)
                    {
                        GuildControl.getInstance().guildBox.btn.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                    }
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12418"), LanguageCfgObj.getInstance().getByIndex("12419"), null, function () : void
                {
                    GuildControl.getInstance().reqGuildImpeach(UserObj.getInstance().playerInfo.guildId);
                    return;
                }// end function
                , null, 2);
                }
                return;
            }// end function
            , null, 2);
            Global.popManager.removeServerToCue(this);
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
