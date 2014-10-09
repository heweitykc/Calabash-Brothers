package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import com.game.utils.*;
    import flash.events.*;

    public class GuildAppointPanel extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var check_btn1:BaseButton;
        private var check_btn2:BaseButton;
        private var check_btn3:BaseButton;
        private var check_btn4:BaseButton;
        private var yes_btn:BaseButton;
        private var btnAry:Array;
        private var curSeletBtn:BaseButton;

        public function GuildAppointPanel()
        {
            this.btnAry = [];
            loadDisplay("res/guildappoint.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("guildAppoint");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.check_btn1 = new BaseButton(getDisplayChildByName("check_btn1"));
            this.check_btn2 = new BaseButton(getDisplayChildByName("check_btn2"));
            this.check_btn3 = new BaseButton(getDisplayChildByName("check_btn3"));
            this.check_btn4 = new BaseButton(getDisplayChildByName("check_btn4"));
            this.check_btn1.setText(LanguageCfgObj.getInstance().getByIndex("10748"));
            this.check_btn2.setText(LanguageCfgObj.getInstance().getByIndex("10749"));
            this.check_btn3.setText(LanguageCfgObj.getInstance().getByIndex("10750"));
            this.check_btn4.setText(LanguageCfgObj.getInstance().getByIndex("10751"));
            this.btnAry.push(this.check_btn1, this.check_btn2, this.check_btn3, this.check_btn4);
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.setText(LanguageCfgObj.getInstance().getByIndex("10752"));
            this.check_btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.check_btn2.addEvtListener(MouseEvent.CLICK, this.__click);
            this.check_btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.check_btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click2);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 5, 5);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            var _loc_3:* = 0;
            while (_loc_3 < this.btnAry.length)
            {
                
                if (this.btnAry[_loc_3] == event.target)
                {
                    this.btnAry[_loc_3].selected = true;
                    this.curSeletBtn = event.target as BaseButton;
                }
                else
                {
                    this.btnAry[_loc_3].selected = false;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            var index:int;
            var userId:long;
            var e:* = event;
            switch(e.target)
            {
                case this.yes_btn:
                {
                    index = (this.btnAry.indexOf(this.curSeletBtn) + 1);
                    if (index == 0)
                    {
                        return;
                    }
                    if (GuildData.getInstance().openOrigin == 1)
                    {
                        userId = GuildControl.getInstance().guildBox.guildInfoView.curSelectItem.info.userId;
                    }
                    else if (GuildData.getInstance().openOrigin == 2)
                    {
                        userId = GuildControl.getInstance().guildChatBox.curSelectPerson.userId;
                    }
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel < index)
                    {
                        GuildControl.getInstance().reqGuildChangePowerLevel(GuildData.getInstance().myMemberInfo.guildId, userId, index);
                    }
                    else if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1 && GuildData.getInstance().myMemberInfo.guildPowerLevel == index)
                    {
                        Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12057"), "", null, function () : void
            {
                var _loc_1:* = 0;
                if (GuildData.getInstance().openOrigin == 1)
                {
                    _loc_1 = GuildControl.getInstance().guildBox.guildInfoView.curSelectItem.info.level;
                }
                else if (GuildData.getInstance().openOrigin == 2)
                {
                    _loc_1 = GuildControl.getInstance().guildChatBox.curSelectPerson.level;
                }
                if (_loc_1 < 100)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12058"));
                }
                else
                {
                    GuildControl.getInstance().reqGuildChangePowerLevel(GuildData.getInstance().myMemberInfo.guildId, userId, index);
                }
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10753"));
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10754"));
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

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
