package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.guild.control.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildCreatPannel extends BaseBox
    {
        private var txt_des:TextField;
        private var txt_guildName:TextField;
        private var btn_creat:BaseButton;
        private var closeBtn:BaseButton;
        private var unLegalWord:Array;
        private var needMoney:int = 1000000;
        private var needLev:int = 100;

        public function GuildCreatPannel()
        {
            this.unLegalWord = ["日"];
            loadDisplay("res/creatguildpanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildCreatBox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_guildName = getDisplayChildByName("txt_guildName");
            this.txt_guildName.text = LanguageCfgObj.getInstance().getByIndex("10780");
            this.btn_creat = new BaseButton(getDisplayChildByName("btn_creat"));
            this.btn_creat.setText(LanguageCfgObj.getInstance().getByIndex("10781"));
            this.closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn_creat.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.txt_guildName.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this.txt_guildName.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            return;
        }// end function

        private function focusInHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_guildName:
                {
                    if (event.target.text == LanguageCfgObj.getInstance().getByIndex("10780"))
                    {
                        event.target.text = "";
                    }
                    this.txt_guildName.textColor = 15850156;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function focusOutHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_guildName:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = LanguageCfgObj.getInstance().getByIndex("10780");
                        this.txt_guildName.textColor = 7566194;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            switch(event.target)
            {
                case this.btn_creat:
                {
                    if (this.checkLegalAble())
                    {
                        GuildControl.getInstance().reqCreateGuild(this.txt_guildName.text, "abc", 1);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function checkLegalAble() : Boolean
        {
            if (!UserObj.getInstance().chechMoneyEnough(this.needMoney))
            {
                Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12067"), [this.needMoney]));
                return false;
            }
            if (UserObj.getInstance().playerInfo.level < this.needLev)
            {
                Global.popManager.addedToMouseCue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12068"), [this.needLev]));
                return false;
            }
            var _loc_1:* = this.txt_guildName.text;
            if (_loc_1 == "" || _loc_1 == LanguageCfgObj.getInstance().getByIndex("10780"))
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10784"));
                return false;
            }
            if (_loc_1.length < 2 || _loc_1.length > 12)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10785"));
                return false;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.unLegalWord.length)
            {
                
                if (_loc_1.indexOf(this.unLegalWord[_loc_2]) != -1)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10786"));
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

        public function update() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
