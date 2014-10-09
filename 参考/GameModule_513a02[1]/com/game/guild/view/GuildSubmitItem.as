package com.game.guild.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildSubmitItem extends ListItemBase implements IItem
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var txt5:TextField;
        private var txt6:TextField;
        private var mc_gold:MovieClip;
        private var _info:Object;

        public function GuildSubmitItem(param1:String = "state1Item")
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
            this.mc_gold = _content.getChildByName("mc_gold") as MovieClip;
            this.mc_gold.visible = false;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt1.textColor = param1;
            this.txt2.textColor = param1;
            this.txt3.textColor = param1;
            this.txt4.textColor = param1;
            this.txt5.textColor = param1;
            this.txt6.textColor = param1;
            return;
        }// end function

        public function setGoldVisible(param1:Boolean = true) : void
        {
            this.mc_gold.visible = param1;
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
                    this.txt1.text = param1.userName;
                    this.txt2.text = param1.dragonHistory;
                    this.txt3.text = param1.whiteTigerHistory;
                    this.txt4.text = param1.suzakuHistory;
                    this.txt5.text = param1.basalticHistory;
                    this.txt6.text = param1.stockGoldHistory;
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
