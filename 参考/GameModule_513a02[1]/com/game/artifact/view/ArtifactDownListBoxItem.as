package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactDownListBoxItem extends BaseSprite implements IItem
    {
        private var display:MovieClip;
        private var _bgMouseOver:DisplayObjectContainer;
        private var _label:TextField;
        private var _selected:Boolean = false;
        private var _obj:Object;
        private static var COLOR_MOUSE_OUT:uint = 8743233;
        private static var COLOR_MOUSE_OVER:uint = 16764006;

        public function ArtifactDownListBoxItem(param1:uint, param2:String)
        {
            this.display = ToolKit.getNew("artifactDownListBoxItem");
            addChild(this.display);
            mouseChildren = false;
            this._bgMouseOver = this.display.getChildByName("bgMouseOver") as DisplayObjectContainer;
            this._label = this.display.getChildByName("label") as TextField;
            this._bgMouseOver.getChildAt(0).width = param1;
            this._label.width = param1;
            var _loc_3:* = this._label.defaultTextFormat;
            _loc_3.align = param2;
            this._label.defaultTextFormat = _loc_3;
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this.setRollOvered(false);
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set obj(param1) : void
        {
            this._obj = param1;
            this._label.text = this._obj.label;
            return;
        }// end function

        public function get label() : String
        {
            return this._label.text;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            this.setRollOvered(true);
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this.setRollOvered(false);
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            this._selected = param1;
            this.setViewState(this._selected);
            return;
        }// end function

        private function setRollOvered(param1:Boolean) : void
        {
            if (!this.selected)
            {
                this.setViewState(param1);
            }
            return;
        }// end function

        private function setViewState(param1:Boolean) : void
        {
            this._bgMouseOver.visible = param1;
            this._label.textColor = param1 ? (COLOR_MOUSE_OVER) : (COLOR_MOUSE_OUT);
            return;
        }// end function

    }
}
