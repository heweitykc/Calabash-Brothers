package com.game.costgoods.control
{
    import com.*;
    import com.game.costgoods.view.*;
    import com.model.vo.*;

    public class CostGoodsControl extends Object
    {
        private var _box:CostGoodsBox;
        private static var _inst:CostGoodsControl;

        public function CostGoodsControl()
        {
            return;
        }// end function

        public function openCost(param1:PropInfo, param2:String, param3:Array = null, param4:Function = null, param5:Function = null) : void
        {
            if (!this._box)
            {
                this._box = new CostGoodsBox();
                Global.popManager.addPop(this._box, false, false, true, true, false, true);
            }
            this._box.params = param3;
            this._box.info = param1;
            this._box.des = param2;
            this._box.yesFun = param4;
            this._box.noFun = param5;
            this._box.openOrClose();
            return;
        }// end function

        public static function getInstance() : CostGoodsControl
        {
            var _loc_1:* = new CostGoodsControl;
            _inst = new CostGoodsControl;
            return _inst || _loc_1;
        }// end function

    }
}
