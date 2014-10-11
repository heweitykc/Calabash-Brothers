package com.game.casting.view.component
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.icon.*;

    public class ItemsShowView extends BaseSprite
    {
        private const interX:int = 91;
        private const interY:int = 72;

        public function ItemsShowView()
        {
            move(0, 0);
            return;
        }// end function

        public function showItems() : void
        {
            var _loc_6:* = null;
            ToolKit.clearMcChild(this);
            var _loc_1:* = QCastingShowCfgObj.getInstance().getList();
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_3 < 12 && _loc_3 < _loc_2)
            {
                
                _loc_6 = new EquipIconItem("BackGroundBorderSize64");
                _loc_6.setWH(66, 66);
                _loc_6.setInfo(_loc_1[_loc_3]);
                _loc_6._x = _loc_4;
                _loc_6._y = _loc_5;
                addChild(_loc_6);
                if (_loc_3 < 3)
                {
                    _loc_4 = _loc_4 + this.interX;
                }
                else if (_loc_3 < 6)
                {
                    _loc_5 = _loc_5 + this.interY;
                }
                else if (_loc_3 < 9)
                {
                    _loc_4 = _loc_4 - this.interX;
                }
                else
                {
                    _loc_5 = _loc_5 - this.interY;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
