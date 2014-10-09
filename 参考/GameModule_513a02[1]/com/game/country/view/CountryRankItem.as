package com.game.country.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryRankItem extends ListItemBase implements IItem
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var txt4:TextField;
        private var txt5:TextField;
        private var mc_rank:MovieClip;
        private var _info:Object;

        public function CountryRankItem(param1:String = "guildDetailRankListItem")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt1 = _content.getChildByName("txt1") as TextField;
            this.txt1.selectable = false;
            this.txt2 = _content.getChildByName("txt2") as TextField;
            this.txt2.selectable = false;
            this.txt3 = _content.getChildByName("txt3") as TextField;
            this.txt3.selectable = false;
            this.txt4 = _content.getChildByName("txt4") as TextField;
            this.txt4.selectable = false;
            this.txt5 = _content.getChildByName("txt5") as TextField;
            this.txt5.selectable = false;
            mcBack = _content.getChildByName("mc") as MovieClip;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt1.textColor = param1;
            this.txt2.textColor = param1;
            this.txt3.textColor = param1;
            this.txt4.textColor = param1;
            this.txt5.textColor = param1;
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            _index = param1;
            setBackFrame(_index % 2 == 0 ? (1) : (2));
            if (param1 == 0)
            {
                var _loc_2:* = 16770390;
                this.txt5.textColor = 16770390;
                this.txt4.textColor = _loc_2;
                this.txt3.textColor = _loc_2;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            else if (param1 == 1)
            {
                var _loc_2:* = 33243;
                this.txt5.textColor = 33243;
                this.txt4.textColor = _loc_2;
                this.txt3.textColor = _loc_2;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            else if (param1 == 2)
            {
                var _loc_2:* = 1411328;
                this.txt5.textColor = 1411328;
                this.txt4.textColor = _loc_2;
                this.txt3.textColor = _loc_2;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            else
            {
                var _loc_2:* = 8417369;
                this.txt5.textColor = 8417369;
                this.txt4.textColor = _loc_2;
                this.txt3.textColor = _loc_2;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
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
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        override protected function setSelect() : void
        {
            if (selected)
            {
                if (mcBack)
                {
                    mcBack.gotoAndStop(4);
                }
            }
            else if (mcBack)
            {
                mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
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
                    this.txt1.text = param1.ranking;
                    this.txt2.text = param1.playername;
                    this.txt3.text = param1.guildname;
                    this.txt4.text = param1.kill;
                    this.txt5.text = param1.conKill;
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
