package com.game.goldRaffle.view.component
{
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;

    public class FractionBoxItem extends BaseSprite
    {
        private var _backImage:Object;
        private var _content:FractionItemContent;
        private var _needFraction:int;

        public function FractionBoxItem(param1:String = "goldRaffles_fractionBg")
        {
            if (param1 && param1.length > 0)
            {
                this._backImage = ToolKit.getNewDO(param1);
                addChild(this._backImage);
            }
            buttonMode = true;
            return;
        }// end function

        public function setInfo(param1:Fraction) : void
        {
            if (!param1)
            {
                return;
            }
            this._content = new FractionItemContent();
            this._content.move(16, 11);
            this.addChild(this._content);
            this._content.info = param1;
            this._needFraction = param1.fraction_type;
            return;
        }// end function

        public function isCanExchange(param1:int) : void
        {
            if (!this._content)
            {
                return;
            }
            if (this._needFraction > param1)
            {
            }
            else
            {
                this._content.enable = true;
            }
            return;
        }// end function

    }
}
