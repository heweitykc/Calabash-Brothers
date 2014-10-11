package com.game.guild.view
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.guild.bean.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildBannerChangeLevelPanel extends BaseBox
    {
        private var txt_matrial:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var no_btn:BaseButton;
        private var goodsNameArray:Array;

        public function GuildBannerChangeLevelPanel()
        {
            this.goodsNameArray = [LanguageCfgObj.getInstance().getByIndex("12059"), LanguageCfgObj.getInstance().getByIndex("12060"), LanguageCfgObj.getInstance().getByIndex("12061"), LanguageCfgObj.getInstance().getByIndex("12062"), LanguageCfgObj.getInstance().getByIndex("12063"), LanguageCfgObj.getInstance().getByIndex("12064")];
            loadDisplay("res/guildchangebannerlevel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildBannerChangeLevel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_matrial = getDisplayChildByName("txt_matrial");
            this.txt_matrial.mouseWheelEnabled = false;
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.setText(LanguageCfgObj.getInstance().getByIndex("10757"));
            this.no_btn = new BaseButton(getDisplayChildByName("no_btn"));
            this.no_btn.setText(LanguageCfgObj.getInstance().getByIndex("10758"));
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
            switch(event.target)
            {
                case this.yes_btn:
                {
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1)
                    {
                        GuildControl.getInstance().reqGuildBannerLevelUp(UserObj.getInstance().playerInfo.guildId);
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10759"));
                    }
                    break;
                }
                case this.no_btn:
                {
                    this.__close();
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
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (UILoaded)
            {
                _loc_1 = GuildData.getInstance().guildInfo.bannerLevel;
                if (_loc_1 >= 10)
                {
                    this.txt_matrial.htmlText = LanguageCfgObj.getInstance().getByIndex("10760");
                    return;
                }
                _loc_2 = BannerCfgObj.getInstance().getGuildBannerinfoByLev((_loc_1 + 1));
                _loc_3 = _loc_2.levelup.split("_");
                _loc_4 = _loc_3[0];
                _loc_5 = _loc_3[0];
                _loc_4 = _loc_4.slice(0, _loc_4.length - 4);
                _loc_3[0] = _loc_4 == "" ? ("0") : (_loc_4);
                _loc_6 = GuildData.getInstance().guildInfo;
                _loc_7 = _loc_6.stockGold.toNumber() >= _loc_5 ? ("00ff00") : ("ff0000");
                _loc_8 = _loc_6.dragon >= _loc_3[1] ? ("00ff00") : ("ff0000");
                _loc_9 = _loc_6.whiteTiger >= _loc_3[2] ? ("00ff00") : ("ff0000");
                _loc_10 = _loc_6.suzaku >= _loc_3[3] ? ("00ff00") : ("ff0000");
                _loc_11 = _loc_6.basaltic >= _loc_3[4] ? ("00ff00") : ("ff0000");
                if (_loc_3[5])
                {
                    _loc_12 = _loc_6.guildContribution >= _loc_3[5] ? ("00ff00") : ("ff0000");
                }
                _loc_4 = "";
                if (int(_loc_3[0]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_7 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[4] + "：" + ToolKit.getMoneyString(_loc_3[0]) + LanguageCfgObj.getInstance().getByIndex("11782") + (_loc_6.stockGold.toNumber() >= _loc_5 ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>\n");
                }
                if (int(_loc_3[5]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_12 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[5] + "：" + _loc_3[5] + (_loc_6.guildContribution >= _loc_3[5] ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>\n");
                }
                if (int(_loc_3[1]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_8 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[0] + "：" + _loc_3[1] + (_loc_6.dragon >= _loc_3[1] ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>\n");
                }
                if (int(_loc_3[2]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_9 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[1] + "：" + _loc_3[2] + (_loc_6.whiteTiger >= _loc_3[2] ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>\n");
                }
                if (int(_loc_3[3]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_10 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[2] + "：" + _loc_3[3] + (_loc_6.suzaku >= _loc_3[3] ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>\n");
                }
                if (int(_loc_3[4]))
                {
                    _loc_4 = _loc_4 + ("<font color=\'#" + _loc_11 + "\'>" + LanguageCfgObj.getInstance().getByIndex("12064") + this.goodsNameArray[3] + "：" + _loc_3[4] + (_loc_6.basaltic >= _loc_3[4] ? (LanguageCfgObj.getInstance().getByIndex("12019")) : (LanguageCfgObj.getInstance().getByIndex("12020"))) + "</font>");
                }
                this.txt_matrial.htmlText = _loc_4;
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
