package com.game.country.view
{
    import avmplus.*;
    import com.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.country.control.*;
    import com.game.guild.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryTools extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var needLevel:int = 1;
        private var needContribution:int = 10;

        public function CountryTools()
        {
            loadDisplay("res/countrytool.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("countryTool");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10588"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10588"));
            this.btn2.enabled = false;
            this.txt1 = getDisplayChildByName("txt1");
            this.txt2 = getDisplayChildByName("txt2");
            this.txt3 = getDisplayChildByName("txt3");
            this.txt1.selectable = false;
            this.txt2.selectable = false;
            this.txt3.selectable = false;
            this.txt3.text = LanguageCfgObj.getInstance().getByIndex("10590");
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_1.addEvtListener(RoleEvent.UPDATE_BECOME, this.closeMe);
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            switch(event.target)
            {
                case this.btn1:
                {
                    _loc_2 = GuildData.getInstance().guildInfo.bannerLevel;
                    _loc_3 = GuildData.getInstance().myMemberInfo.contributionPoint;
                    if (_loc_2 < this.needLevel)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10591"));
                        return;
                    }
                    if (_loc_3 < this.needContribution)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10592"));
                        return;
                    }
                    CountryControl.getInstance().reqAddCountryBuff();
                    break;
                }
                case this.btn2:
                {
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
            var _loc_1:* = GuildData.getInstance().guildInfo.bannerLevel;
            var _loc_2:* = GuildData.getInstance().myMemberInfo.contributionPoint;
            if (_loc_1 < this.needLevel)
            {
                this.txt1.textColor = 16711680;
            }
            else
            {
                this.txt1.textColor = 65280;
            }
            if (_loc_2 < this.needContribution)
            {
                this.txt2.textColor = 16711680;
            }
            else
            {
                this.txt2.textColor = 65280;
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        public function closeMe(event:RoleEvent) : void
        {
            if (event.obj)
            {
                super.close();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

    }
}
