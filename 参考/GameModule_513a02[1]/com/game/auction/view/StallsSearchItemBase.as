package com.game.auction.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class StallsSearchItemBase extends ListItemBase implements IItem
    {
        public var txt:TextField;

        public function StallsSearchItemBase(param1:String = "stallsItemName")
        {
            super(param1);
            mouseChildren = false;
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt = _content.getChildByName("txt") as TextField;
            mcBack = _content.getChildByName("mc") as MovieClip;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txt.textColor = param1;
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!selected)
            {
                this.txt.textColor = 65532;
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
                this.txt.textColor = 16766079;
                if (mcBack)
                {
                    mcBack.gotoAndStop(index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return null;
        }// end function

        public function set obj(param1) : void
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
