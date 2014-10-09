package com.view
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.model.*;
    import flash.display.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class RoofsContainer extends BaseSprite
    {
        private var _roofs:Array;
        private var _roofpng:Dictionary;
        private var _user:IRoleView;
        public static const MAP_MAPRES_PATH:String = "art/res/map/mapres/";

        public function RoofsContainer()
        {
            this.mouseEnabled = false;
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            this.showRoofs(param1, param2);
            super.move(param1, param2);
            return;
        }// end function

        public function setRoofs(param1:Array) : void
        {
            this._roofs = param1;
            this._roofpng = new Dictionary();
            return;
        }// end function

        public function reset() : void
        {
            ToolKit.clearMcChild(this);
            this._roofs = new Array();
            this._roofpng = new Dictionary();
            return;
        }// end function

        protected function showRoofs(param1:Number, param2:Number) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._user = RoleList.getInstance().player;
            var _loc_3:* = 400;
            if (!this._roofs)
            {
                return;
            }
            for each (_loc_5 in this._roofs)
            {
                
                if (_loc_5 == null)
                {
                    continue;
                }
                if (-param1 - _loc_3 > _loc_5.x || -param1 + FrameworkGlobal.stageW + 0 < _loc_5.x || -param2 - _loc_3 > _loc_5.y || -param2 + 0 + FrameworkGlobal.stageH < _loc_5.y)
                {
                    if (this._roofpng[_loc_5] && this._roofpng[_loc_5].parent)
                    {
                        removeChild(this._roofpng[_loc_5]);
                    }
                    this._roofpng[_loc_5] = null;
                    continue;
                }
                if (!this._roofpng[_loc_5])
                {
                    if ((_loc_5.name as String).search(".png") != -1 || (_loc_5.name as String).search(".jpg") != -1)
                    {
                        _loc_6 = new Image();
                        _loc_6.load(MAP_MAPRES_PATH + "roof/" + _loc_5.name);
                        _loc_6.move(_loc_5.x, _loc_5.y);
                        _loc_6.rotation = _loc_5.r ? (_loc_5.r) : (0);
                        _loc_6.scaleX = _loc_5.s ? (_loc_5.s) : (1);
                        addChild(_loc_6);
                        this._roofpng[_loc_5] = _loc_6;
                    }
                }
                _loc_4 = this._roofpng[_loc_5] && this._user && (this._user as Sprite).hitTestObject(this._roofpng[_loc_5]);
                if (_loc_4)
                {
                    this._roofpng[_loc_5].alpha = 0.1;
                    continue;
                }
                this._roofpng[_loc_5].alpha = 1;
            }
            return;
        }// end function

    }
}
