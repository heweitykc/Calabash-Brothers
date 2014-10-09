package com.game.autopk.view.render
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class NumItemRender extends ListItemBase implements IItem
    {
        private var _label:TextField;
        private var _date:Object;

        public function NumItemRender()
        {
            super("NumItemRenderSkin");
            return;
        }// end function

        override protected function getComp() : void
        {
            mcBack = _content.getChildByName("bg") as MovieClip;
            this._label = _content.getChildByName("label") as TextField;
            if (this._date)
            {
                this._label.text = this._date.label;
            }
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this._label.text = param1;
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._date;
        }// end function

        public function set obj(param1) : void
        {
            this._date = param1;
            if (this._label)
            {
                this._label.text = this._date.label;
            }
            return;
        }// end function

        public function get label() : String
        {
            return this._label.text;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                this._label.textColor = 16750848;
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
                this._label.textColor = 8743233;
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            selected = param1;
            return;
        }// end function

    }
}
