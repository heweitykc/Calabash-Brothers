package com.game.supervip.view
{
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;

    public class SupervipItemView extends IconItem
    {
        public static var WIDTH:int = 56;
        public static var HEIGHT:int = 56;

        public function SupervipItemView()
        {
            super(createBg());
            initHitArea();
            setImageSize(WIDTH, HEIGHT);
            return;
        }// end function

        public function setItemModelId(param1:int) : void
        {
            var _loc_2:* = PropUtil.createItemByCfg(param1);
            setInfo(_loc_2);
            return;
        }// end function

        private static function createBg() : Shape
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.beginFill(0, 0);
            _loc_1.graphics.drawRect(0, 0, WIDTH, HEIGHT);
            _loc_1.graphics.endFill();
            return _loc_1;
        }// end function

    }
}
