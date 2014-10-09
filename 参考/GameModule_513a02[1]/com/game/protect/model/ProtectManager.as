package com.game.protect.model
{
    import com.model.vo.*;
    import com.view.icon.*;

    public class ProtectManager extends Object
    {
        public static var itemViewProtectMarkUpdater:Function;
        public static var itemViewHighProtectMarkUpdater:Function;

        public function ProtectManager()
        {
            return;
        }// end function

        public static function updateItemView(param1:IconItem, param2:PropInfo) : void
        {
            if (itemViewProtectMarkUpdater != null)
            {
                itemViewProtectMarkUpdater(param1, param2);
            }
            return;
        }// end function

        public static function updateItemViewHigh(param1:IconItem, param2:PropInfo) : void
        {
            if (itemViewHighProtectMarkUpdater != null)
            {
                itemViewHighProtectMarkUpdater(param1, param2);
            }
            return;
        }// end function

    }
}
