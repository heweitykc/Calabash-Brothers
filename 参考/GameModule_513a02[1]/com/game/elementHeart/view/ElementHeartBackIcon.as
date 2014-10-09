package com.game.elementHeart.view
{
    import com.staticdata.*;

    public class ElementHeartBackIcon extends ElementIconItem
    {

        public function ElementHeartBackIcon(param1:String = "magicBook_skilllock")
        {
            type = ElementLocateType.HOUSE;
            super(param1);
            _isDrag = false;
            _accpetKey = [];
            return;
        }// end function

    }
}
