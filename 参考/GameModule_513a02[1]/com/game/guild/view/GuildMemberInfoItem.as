package com.game.guild.view
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.utils.*;
    import com.game.guild.model.*;
    import com.game.role.view.*;
    import com.game.team.view.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildMemberInfoItem extends ListItemBase implements IItem
    {
        private const COLOR_OFFLINE:uint = 6710886;
        private const COLOR_MY:uint = 39168;
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var txt5:TextField;
        private var txt6:TextField;
        private var txtLevIcon:RoleLevelIcon;
        private var bg:MovieClip;
        private var _info:Object;

        public function GuildMemberInfoItem(param1:String = "state1Item")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt1 = _content.getChildByName("txt1") as TextField;
            this.txt2 = _content.getChildByName("txt2") as TextField;
            this.txt3 = _content.getChildByName("txt3") as TextField;
            this.txt4 = _content.getChildByName("txt4") as TextField;
            this.txt5 = _content.getChildByName("txt5") as TextField;
            this.txt6 = _content.getChildByName("txt6") as TextField;
            mcBack = _content.getChildByName("mc") as MovieClip;
            this.txtLevIcon = new RoleLevelIcon();
            this.txtLevIcon.x = this.txt2.x;
            this.txtLevIcon.y = this.txt2.y;
            _content.addChild(this.txtLevIcon);
            this.setWH(695, 22);
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt1.textColor = param1;
            this.txt2.textColor = param1;
            this.txtLevIcon.textColor = param1;
            this.txt3.textColor = param1;
            this.txt4.textColor = param1;
            this.txt5.textColor = param1;
            this.txt6.textColor = param1;
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(this.obj, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    this.txt1.text = param1.userName;
                    this.txt2.text = "";
                    this.txtLevIcon.level = param1.level;
                    this.txt3.text = GuildData.getInstance().getGuildPowerName(param1.guildPowerLevel);
                    this.txt4.text = param1.fightPower;
                    this.txt5.text = param1.contributionPointWeek;
                    this.txt6.text = ToolKit.getLastLoginTime2(param1.lastOnlineTime * 1000);
                    if (UserObj.getInstance().playerInfo.personId.equal(param1.userId))
                    {
                        this.setTextColor(this.COLOR_MY);
                    }
                    else if (param1.lastOnlineTime)
                    {
                        this.setTextColor(this.COLOR_OFFLINE);
                    }
                    else
                    {
                        this.setTextColor(COLOR_NORMAL);
                    }
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                }
            }
            return;
        }// end function

        override protected function setSelect() : void
        {
            if (this.selected)
            {
                this.setTextColor(COLOR_SELECT);
                if (mcBack)
                {
                    mcBack.gotoAndStop(4);
                }
            }
            else
            {
                if (UserObj.getInstance().playerInfo.personId.equal(this.info.userId))
                {
                    this.setTextColor(this.COLOR_MY);
                }
                else if (this.info.lastOnlineTime)
                {
                    this.setTextColor(this.COLOR_OFFLINE);
                }
                else
                {
                    this.setTextColor(COLOR_NORMAL);
                }
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                this.setTextColor(COLOR_SELECT);
                if (mcBack)
                {
                    mcBack.gotoAndStop(3);
                }
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                if (UserObj.getInstance().playerInfo.personId.equal(this.info.userId))
                {
                    this.setTextColor(this.COLOR_MY);
                }
                else if (this.info.lastOnlineTime)
                {
                    this.setTextColor(this.COLOR_OFFLINE);
                }
                else
                {
                    this.setTextColor(COLOR_NORMAL);
                }
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
