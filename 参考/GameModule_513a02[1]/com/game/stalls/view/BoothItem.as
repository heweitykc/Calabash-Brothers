package com.game.stalls.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.stalls.events.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class BoothItem extends Component
    {
        private var _info:StallsBriefInfo;
        private var _selected:Boolean;
        private var _indexTxt:TextField;
        private var _boothNameTxt:TextField;
        private var _playerNameTxt:TextField;
        private var _levelTxt:TextField;
        private var _bg:MovieClip;
        private var _numTxt:TextField;
        private var _index:int = 0;
        protected const COLOR_NORMAL:uint = 16766079;
        protected const COLOR_SELECT:uint = 65532;
        private var _selectIndex:int;
        private var _priTimer:int;

        public function BoothItem(param1:String = "boothitem")
        {
            super.initComponentUI(param1);
            this.initUI();
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        public function get selectIndex() : int
        {
            return this._selectIndex;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            this._selectIndex = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        private function initUI() : void
        {
            this._indexTxt = getDisplayChildByName("txt_index");
            this._boothNameTxt = getDisplayChildByName("txt_stallsName");
            this._playerNameTxt = getDisplayChildByName("txt_playerName");
            this._levelTxt = getDisplayChildByName("txt_level");
            this._numTxt = getDisplayChildByName("txt_num");
            this._bg = getDisplayChildByName("back");
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            if (param1)
            {
                this._bg.gotoAndStop(4);
                this.setTextColor(this.COLOR_SELECT);
            }
            else
            {
                if (this._bg)
                {
                    this._bg.gotoAndStop(this._selectIndex % 2 == 0 ? (1) : (2));
                }
                this.setTextColor(this.COLOR_NORMAL);
            }
            return;
        }// end function

        public function get info() : StallsBriefInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsBriefInfo) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        protected function setBackFrame(param1:int) : void
        {
            if (this._bg)
            {
                this._bg.gotoAndStop(param1);
            }
            return;
        }// end function

        private function update() : void
        {
            this._indexTxt.text = this._index.toString();
            this.setBackFrame(this._selectIndex % 2 == 0 ? (1) : (2));
            if (StringUtil.trim(this._info.stallsname) == "")
            {
                this._boothNameTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12205"), [this._info.playername]);
            }
            else
            {
                this._boothNameTxt.text = this._info.stallsname;
            }
            this._playerNameTxt.text = this.getPlayerName(this._info.playername);
            if (this._info.playerlv == -1)
            {
                this._levelTxt.text = "NPC";
            }
            else
            {
                this._levelTxt.text = this._info.playerlv.toString();
            }
            this._numTxt.text = this._info.sellgoodsnum.toString();
            return;
        }// end function

        private function getPlayerName(param1:String) : String
        {
            var _loc_2:* = param1.indexOf("]");
            return param1.substr((_loc_2 + 1));
        }// end function

        public function clear() : void
        {
            this._indexTxt.text = "";
            this._boothNameTxt.text = "";
            this._playerNameTxt.text = "";
            this._levelTxt.text = "";
            this._numTxt.text = "";
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.over();
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.out();
            }
            return;
        }// end function

        private function over() : void
        {
            this._bg.gotoAndStop(3);
            this.setTextColor(this.COLOR_SELECT);
            return;
        }// end function

        private function out() : void
        {
            if (this._bg)
            {
                this._bg.gotoAndStop(this._selectIndex % 2 == 0 ? (1) : (2));
            }
            this.setTextColor(this.COLOR_NORMAL);
            return;
        }// end function

        protected function singleClick() : void
        {
            if (this._info == null)
            {
                return;
            }
            dispatchEvent(new StallsEvent(StallsEvent.SELECTED, this, true));
            return;
        }// end function

        protected function setTextColor(param1:uint) : void
        {
            this._indexTxt.textColor = param1;
            this._boothNameTxt.textColor = param1;
            this._playerNameTxt.textColor = param1;
            this._levelTxt.textColor = param1;
            this._numTxt.textColor = param1;
            return;
        }// end function

        protected function doDoubleClick() : void
        {
            if (this._info == null)
            {
                return;
            }
            dispatchEvent(new StallsEvent(StallsEvent.INFO, this, true));
            return;
        }// end function

        protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 300)
            {
                this.doDoubleClick();
                this._priTimer = 0;
            }
            else
            {
                this.singleClick();
                this._priTimer = _loc_2;
            }
            return;
        }// end function

    }
}
