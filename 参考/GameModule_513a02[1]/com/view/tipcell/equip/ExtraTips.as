package com.view.tipcell.equip
{
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import flash.display.*;

    public class ExtraTips extends Sprite
    {
        private var _gap:int = 8;
        private var _paddingLeft:int = 16;
        private var _paddingTop:int = 12;
        private var _extraImg:Sprite;
        private var _box:HBox;

        public function ExtraTips()
        {
            this._extraImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._extraImg);
            this._box = new HBox();
            this._box.move(this._paddingLeft + 16, this._paddingTop);
            this._box.intervalY = this._gap;
            addChild(this._box);
            return;
        }// end function

        public function addItem(param1) : void
        {
            this._box.addAt(param1, 0);
            return;
        }// end function

        public function removeItem(param1) : void
        {
            this._box.remove(param1);
            return;
        }// end function

        public function update() : void
        {
            this._box.update();
            this._extraImg.width = this._box.width + this._paddingLeft * 2;
            this._extraImg.height = this._box.height + this._paddingTop * 2;
            return;
        }// end function

    }
}
