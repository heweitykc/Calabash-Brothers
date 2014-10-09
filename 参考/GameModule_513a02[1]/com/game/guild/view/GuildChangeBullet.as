package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildChangeBullet extends BaseBox
    {
        private var txt:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var no_btn:BaseButton;
        private var MAX_CHARS:int = 200;
        private var NOMORL:String;

        public function GuildChangeBullet()
        {
            this.NOMORL = LanguageCfgObj.getInstance().getByIndex("10772");
            loadDisplay("res/guildchangebullet.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("changeGuildBullet");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt = getDisplayChildByName("txt");
            this.txt.maxChars = this.MAX_CHARS;
            this.txt.addEventListener(MouseEvent.CLICK, this.__click);
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.setText(LanguageCfgObj.getInstance().getByIndex("10773"));
            this.no_btn = new BaseButton(getDisplayChildByName("no_btn"));
            this.no_btn.setText(LanguageCfgObj.getInstance().getByIndex("10774"));
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.no_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 5, 5);
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.yes_btn:
                {
                    _loc_2 = this.txt.text;
                    if (_loc_2 != this.NOMORL && _loc_2 != "")
                    {
                        GuildControl.getInstance().reqGuildChangeBulletin(GuildData.getInstance().myMemberInfo.guildId, _loc_2);
                        this.close();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10775"));
                    }
                    break;
                }
                case this.no_btn:
                {
                    this.__close();
                    break;
                }
                case this.txt:
                {
                    if (this.txt.text == this.NOMORL)
                    {
                        this.txt.text = "";
                        this.txt.textColor = 16766079;
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

        private function update() : void
        {
            if (UILoaded)
            {
                this.txt.text = this.NOMORL;
                this.txt.textColor = 7566194;
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
