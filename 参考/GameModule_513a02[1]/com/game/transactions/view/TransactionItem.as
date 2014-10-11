package com.game.transactions.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.game.transactions.control.*;
    import com.game.transactions.events.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TransactionItem extends Component
    {
        private var _remarkTxt:TextField;
        private var _nameTxt:TextField;
        private var _intensifyTxt:TextField;
        private var _box:TransactionBox;
        private var _isMine:Boolean;
        private var _info:PropInfo;
        private var _pos:int;
        private var _bg:MovieClip;

        public function TransactionItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            addEvtListener(TransactionEvent.DRAG_IN, this.__dragIn);
            addEvtListener(TransactionEvent.DRAG_OUT, this.__dragIn);
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get isMine() : Boolean
        {
            return this._isMine;
        }// end function

        public function set isMine(param1:Boolean) : void
        {
            this._isMine = param1;
            this._box.isMine = param1;
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            var _loc_2:* = null;
            this._info = param1;
            this._box.info = param1;
            if (this._info)
            {
                if (this._info is EquipmentInfo)
                {
                    if ((this._info as EquipmentInfo).q_remarkable)
                    {
                        this._remarkTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11380");
                    }
                    else
                    {
                        this._remarkTxt.text = "";
                    }
                    _loc_2 = PropUtil.getEquipNameAndColor(this._info as EquipmentInfo);
                    this._nameTxt.htmlText = "<font color = \'#" + _loc_2[1].toString(16) + "\'>" + this._info.q_name + "</font>";
                    if ((this._info as EquipmentInfo).intensify > 0)
                    {
                        this._intensifyTxt.htmlText = "+" + (this._info as EquipmentInfo).intensify.toString();
                    }
                    else
                    {
                        this._intensifyTxt.text = "";
                    }
                    ItemTips.create(this._box, this._info, EquipTips);
                }
                else
                {
                    this._nameTxt.htmlText = "<font color = \'#" + PropUtil.getPropColor(this._info.q_quality_lv).toString(16) + "\'>" + this._info.q_name + "</font>";
                    this._intensifyTxt.text = "";
                    ItemTips.create(this._box, this._info, PropTips);
                }
                dispatchEvent(new TransactionEvent(TransactionEvent.INSERT, this, true));
            }
            else
            {
                this._remarkTxt.text = "";
                this._intensifyTxt.text = "";
                this._nameTxt.text = "";
                this._box.info = null;
                ItemTips.dispose(this._box);
                dispatchEvent(new TransactionEvent(TransactionEvent.REMOVE, this, true));
            }
            return;
        }// end function

        private function __dragIn(event:TransactionEvent) : void
        {
            this.setItem(event.data);
            return;
        }// end function

        public function __over(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(2);
            return;
        }// end function

        public function __out(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(1);
            return;
        }// end function

        public function setLocked(param1:Boolean) : void
        {
            this._box.isLocked = param1;
            return;
        }// end function

        public function setItem(param1:Object) : void
        {
            if (this._info)
            {
                TransactionControl.getInstance().removeItem(this._info.itemId);
            }
            TransactionControl.getInstance().insertItem(this.pos, param1.itemId);
            return;
        }// end function

        private function initUI() : void
        {
            this._box = new TransactionBox();
            this._box.move(13, 6);
            addChild(this._box);
            this._intensifyTxt = getDisplayChildByName("txt_intensify");
            this._nameTxt = getDisplayChildByName("txt_name");
            this._remarkTxt = getDisplayChildByName("txt_remark");
            this._bg = getDisplayChildByName("bg");
            return;
        }// end function

    }
}
