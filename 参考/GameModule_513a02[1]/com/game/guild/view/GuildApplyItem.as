package com.game.guild.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildApplyItem extends ListItemBase implements IItem
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var txt5:TextField;
        private var txt_rank:TextField;
        private var mc_rank:MovieClip;
        private var mc_rangImg:MovieClip;
        private var _info:Object;

        public function GuildApplyItem(param1:String = "guildListItem")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt1 = _content.getChildByName("txt1") as TextField;
            this.txt1.mouseEnabled = false;
            this.txt2 = _content.getChildByName("txt2") as TextField;
            this.txt2.mouseEnabled = false;
            this.txt3 = _content.getChildByName("txt3") as TextField;
            this.txt3.mouseEnabled = false;
            this.txt4 = _content.getChildByName("txt4") as TextField;
            this.txt4.mouseEnabled = false;
            this.txt5 = _content.getChildByName("txt5") as TextField;
            this.txt5.mouseEnabled = false;
            this.txt_rank = _content.getChildByName("txt_rank") as TextField;
            this.txt_rank.mouseEnabled = false;
            mcBack = _content.getChildByName("mc") as MovieClip;
            this.mc_rank = _content.getChildByName("mc_rank") as MovieClip;
            this.mc_rank.visible = false;
            this.mc_rank.mouseEnabled = false;
            this.mc_rangImg = _content.getChildByName("mc_rangImg") as MovieClip;
            this.mc_rangImg.visible = false;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt1.textColor = param1;
            this.txt2.textColor = param1;
            this.txt3.textColor = param1;
            this.txt4.textColor = param1;
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            _index = param1;
            setBackFrame(_index % 2 == 0 ? (1) : (2));
            switch(param1)
            {
                case 0:
                case 1:
                case 2:
                {
                    this.mc_rank.gotoAndStop((param1 + 1));
                    this.mc_rank.visible = true;
                    this.mc_rangImg.visible = true;
                    this.mc_rangImg.gotoAndStop((param1 + 1));
                    this.txt_rank.visible = false;
                    break;
                }
                default:
                {
                    this.txt_rank.visible = true;
                    this.txt_rank.text = "" + (param1 + 1);
                    break;
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
                    this.mc_rank.visible = false;
                }
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                this.setTextColor(COLOR_NORMAL);
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                    if (index < 3)
                    {
                        this.mc_rank.visible = true;
                    }
                }
            }
            return;
        }// end function

        override protected function setSelect() : void
        {
            if (selected)
            {
                this.setTextColor(COLOR_SELECT);
                if (mcBack)
                {
                    mcBack.gotoAndStop(4);
                    this.mc_rank.visible = false;
                }
            }
            else
            {
                this.setTextColor(COLOR_NORMAL);
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                    if (index < 3)
                    {
                        this.mc_rank.visible = true;
                    }
                }
            }
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
            this.setInfo(this._info, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    this.txt1.text = param1.guildName;
                    this.txt2.text = param1.bangZhuName;
                    this.txt3.text = "" + param1.bannerLevel;
                    this.txt4.text = param1.memberNum;
                    this.txt5.text = param1.memberFightPower;
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    ItemTips.create(this, this._info, GuildListItemTips);
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    ItemTips.dispose(this);
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
