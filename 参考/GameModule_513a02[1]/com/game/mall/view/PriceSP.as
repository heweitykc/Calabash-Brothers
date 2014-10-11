package com.game.mall.view
{
    import com.f1.ui.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.game.mall.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class PriceSP extends Component
    {
        private var _priceTxt:TextField;
        private var _sufTxt:TextField;
        private var _bmp:CurrencyIcon;
        private var _costtype:int;
        private var _lineSp:Sprite;

        public function PriceSP(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this._priceTxt = getDisplayChildByName("txt_price");
            this._lineSp = new Sprite();
            this._lineSp.alpha = 0.6;
            addChild(this._lineSp);
            return;
        }// end function

        public function setPrice(param1:int, param2:int, param3:int) : void
        {
            if (this._costtype != param2)
            {
                if (this._bmp && this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
                this._bmp = IconUtil.getIconSp(param2);
                this._costtype = param2;
                this._bmp.x = this._priceTxt.x - this._bmp.width - 2;
                if (this._priceTxt.defaultTextFormat.size > 12)
                {
                    this._bmp.y = 1;
                }
                else
                {
                    this._bmp.y = 0;
                }
            }
            addChild(this._bmp);
            if (param1 == 1)
            {
                this._priceTxt.text = param3.toString();
            }
            else
            {
                this._priceTxt.htmlText = "<b>" + param3.toString() + "</b>";
            }
            this._lineSp.graphics.clear();
            if (param1 == 1)
            {
                this._lineSp.graphics.lineStyle(2, 16711680);
                this._lineSp.graphics.moveTo(this._bmp.x, 8);
                this._lineSp.graphics.lineTo(this._priceTxt.x + this._priceTxt.textWidth + 2, 8);
                this._lineSp.graphics.endFill();
            }
            addChildAt(this._lineSp, numChildren);
            return;
        }// end function

    }
}
