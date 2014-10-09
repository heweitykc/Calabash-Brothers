package com.game.goldRaffle.view.component
{
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.goldRaffle.control.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.events.*;
    import flash.text.*;

    public class FractionItemContent extends Component
    {
        private var _button:BaseButton;
        private var _txt:TextField;
        private var _box:RaffleBoxItem;
        private var _info:Fraction;

        public function FractionItemContent(param1 = "goldRaffles_fractionCon", param2:String = null)
        {
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._box = new RaffleBoxItem();
            this._box.move(1, 17);
            this.addChild(this._box);
            this._button = new BaseButton(getDisplayChildByName("button"));
            this._button.addEvtListener(MouseEvent.CLICK, this.reqFraction);
            this._txt = getDisplayChildByName("txt");
            return;
        }// end function

        public function set info(param1:Fraction) : void
        {
            this._info = param1;
            this._txt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12049"), [this._info.fraction_type.toString()]);
            var _loc_2:* = PropUtil.createItemByCfg(this._info.fraction_item_id);
            _loc_2.num = this._info.fraction_amount;
            this._box.info = PropUtil.createItemByCfg(this._info.fraction_item_id);
            return;
        }// end function

        private function reqFraction(event:MouseEvent) : void
        {
            GoldRaffleControl.getInstance().reqFraction(this._info.fraction_id);
            return;
        }// end function

        override public function finalize() : void
        {
            this._button.removeEvtListener(MouseEvent.CLICK, this.reqFraction);
            super.finalize();
            return;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            this._button.enabled = param1;
            return;
        }// end function

    }
}
