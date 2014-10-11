package com.f1.view.mapeditor
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class GameBgView extends BgView implements IGameBgView
    {
        private var fragments:Array;
        private var bmps:Dictionary;
        private var _skillBgContain:BaseSprite;
        private var _skillbgEffect:Dictionary;
        private var _swfSprite:BaseSprite;
        private var swfvmcs:Dictionary;
        private var _maskSprite:BaseSprite;
        private var maskpng:Dictionary;
        private var idxX:uint;
        private var idxY:uint;
        private var idxX1:uint;
        private var idxY1:uint;
        private var needLoadURLs:Array;
        private var smalls:Dictionary;
        private static const SMALL_SIZE:uint = 16;

        public function GameBgView()
        {
            this.needLoadURLs = [];
            this.fragments = [];
            this.bmps = new Dictionary();
            this.swfvmcs = new Dictionary();
            this._swfSprite = new BaseSprite();
            this._skillbgEffect = new Dictionary();
            this._skillBgContain = new BaseSprite();
            this._maskSprite = new BaseSprite();
            this._swfSprite.mouseEnabled = false;
            this._skillBgContain.mouseEnabled = false;
            this._maskSprite.mouseEnabled = false;
            FrameworkGlobal.addMsgListen("showBgEffect", this.__showorHideGgEffect);
            FrameworkGlobal.addMsgListen("hideBgEffect", this.__showorHideGgEffect);
            return;
        }// end function

        private function __showorHideGgEffect(event:Event) : void
        {
            if (event.type == "showBgEffect")
            {
                this.move(this.x, this.y);
            }
            else if (event.type == "hideBgEffect")
            {
                this.swfvmcs = new Dictionary();
                this.maskpng = new Dictionary();
                this._swfSprite.finalize();
                this._maskSprite.finalize();
            }
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            super.move(param1, param2);
            this.updateFragment(param1, param2);
            if (FrameworkGlobal.isShowGameEffect)
            {
                this.showbgEffect(param1, param2);
                this.showbgEffectMask(param1, param2);
            }
            return;
        }// end function

        private function updateFragment(param1:Number, param2:Number) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_16:* = null;
            if (!this.fragments)
            {
                return;
            }
            var _loc_3:* = Math.floor((-param1) / fragmentWidth);
            var _loc_4:* = Math.floor((-param2) / fragmentHeight);
            var _loc_5:* = Math.floor((FrameworkGlobal.stageW - param1) / fragmentWidth);
            var _loc_6:* = Math.floor((FrameworkGlobal.stageH - param2) / fragmentHeight);
            if (this.idxX1 != 0 && this.idxX1 != 0)
            {
                if (_loc_3 == this.idxX && _loc_4 == this.idxY && _loc_5 == this.idxX1 && _loc_6 == this.idxY1)
                {
                    return;
                }
            }
            var _loc_10:* = [];
            var _loc_11:* = [];
            var _loc_14:* = uint(_loc_3 + (_loc_5 - _loc_3) / 2);
            var _loc_15:* = uint(_loc_4 + (_loc_6 - _loc_4) / 2);
            _loc_8 = _loc_4;
            while (_loc_8 <= _loc_6)
            {
                
                _loc_12 = _loc_8 * fragmentW;
                _loc_7 = _loc_3;
                while (_loc_7 <= _loc_5)
                {
                    
                    _loc_9 = _loc_12 + _loc_7;
                    _loc_13 = bgSrc + "/bgfm" + _loc_9 + ".jpg";
                    if (this.fragments.indexOf(_loc_9) == -1)
                    {
                        _loc_11.push({url:_loc_13, params:[_loc_9, _loc_7, _loc_8], distance:ToolKit.distanceSQ(_loc_14, _loc_15, _loc_7, _loc_8)});
                        if (this.smalls && this.smalls[_loc_9])
                        {
                            this.showFragment(this.smalls[_loc_9], _loc_9, _loc_7, _loc_8);
                        }
                    }
                    _loc_10.push(_loc_9);
                    _loc_7 = _loc_7 + 1;
                }
                _loc_8 = _loc_8 + 1;
            }
            for each (_loc_9 in this.fragments)
            {
                
                if (_loc_10.indexOf(_loc_9) == -1)
                {
                    _loc_16 = this.bmps[_loc_9];
                    if (_loc_16 && _loc_16.parent)
                    {
                        _loc_16.parent.removeChild(_loc_16);
                        _loc_16.bitmapData.dispose();
                    }
                    this.bmps[_loc_9] = null;
                    delete this.bmps[_loc_9];
                }
            }
            this.fragments = _loc_10;
            this.idxX = _loc_3;
            this.idxY = _loc_4;
            this.idxX1 = _loc_5;
            this.idxY1 = _loc_6;
            if (_loc_11.length > 0)
            {
                _loc_11.sortOn("distance", Array.NUMERIC);
                this.needLoadURLs = this.needLoadURLs.concat(_loc_11);
                this.startLoadFragment();
                this.startLoadFragment();
            }
            return;
        }// end function

        private function startLoadFragment() : void
        {
            var _loc_1:* = null;
            if (this.needLoadURLs && this.needLoadURLs.length > 0)
            {
                _loc_1 = this.needLoadURLs.shift();
                VResManager.load(_loc_1.url, this.addOneFragmentComplete, _loc_1.params, addOneFragmentFail, null, false, false, false, FrameworkGlobal.LOAD_PRELOAD_MAP);
            }
            return;
        }// end function

        override protected function addOneFragmentComplete(param1:BitmapData, param2:int, param3:int, param4:int) : void
        {
            if (this.fragments && this.fragments.length > 0 && this.fragments.indexOf(param2) != -1)
            {
                if (param1 && param1.width > 1 && param1.height > 1)
                {
                    this.showFragment(param1, param2, param3, param4);
                }
            }
            if (this.needLoadURLs.length > 0)
            {
                this.startLoadFragment();
                this.startLoadFragment();
            }
            return;
        }// end function

        override protected function showFragment(param1:BitmapData, param2:int, param3:int, param4:int) : void
        {
            if (!this.bmps)
            {
                return;
            }
            var _loc_5:* = this.bmps[param2];
            if (!this.bmps[param2])
            {
                _loc_5 = new Bitmap(param1);
                _loc_5.x = param3 * fragmentWidth;
                _loc_5.y = param4 * fragmentHeight;
                addChildAt(_loc_5, 0);
                this.bmps[param2] = _loc_5;
            }
            else
            {
                _loc_5.bitmapData = param1;
            }
            if (_loc_5.width != fragmentWidth)
            {
                _loc_5.width = fragmentWidth;
            }
            if (_loc_5.height != fragmentHeight)
            {
                _loc_5.height = fragmentHeight;
            }
            return;
        }// end function

        override protected function loadSmallBgOK(param1:BitmapData) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.width / SMALL_SIZE * (param1.height / SMALL_SIZE);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = new BitmapData(SMALL_SIZE, SMALL_SIZE);
                _loc_3.copyPixels(param1, new Rectangle(Math.floor(_loc_4 % fragmentW) * SMALL_SIZE, Math.floor(_loc_4 / fragmentW) * SMALL_SIZE, SMALL_SIZE, SMALL_SIZE), new Point(0, 0));
                this.smalls[_loc_4] = _loc_3;
                _loc_4++;
            }
            return;
        }// end function

        override protected function addBgFragments() : void
        {
            return;
        }// end function

        protected function showbgEffect(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!swfs)
            {
                return;
            }
            for each (_loc_3 in swfs)
            {
                
                if (-param1 - 200 > _loc_3.x || -param1 + FrameworkGlobal.stageW + 200 < _loc_3.x || -param2 - 200 > _loc_3.y || -param2 + 200 + FrameworkGlobal.stageH < _loc_3.y)
                {
                    if (this.swfvmcs[_loc_3])
                    {
                        if (this.swfvmcs[_loc_3].parent)
                        {
                            if ((_loc_3.name as String).search(".swf") != -1)
                            {
                                this.swfvmcs[_loc_3].stop();
                            }
                            this._swfSprite.removeChild(this.swfvmcs[_loc_3]);
                        }
                        this.swfvmcs[_loc_3] = null;
                    }
                    continue;
                }
                if (this.swfvmcs[_loc_3])
                {
                    continue;
                }
                if ((_loc_3.name as String).search(".png") != -1)
                {
                    _loc_4 = new BaseSprite();
                    _loc_5 = new VMCView();
                    _loc_4.addChild(_loc_5);
                    _loc_5.url = MAP_MAPRES_PATH + "png/" + _loc_3.name;
                    if (!_loc_5.updatePose("90", true, true))
                    {
                        TweenLite.delayedCall(15, this.showOneEffect, [_loc_5]);
                    }
                    _loc_4.move(_loc_3.x, _loc_3.y);
                    _loc_4.rotation = _loc_3.r ? (_loc_3.r) : (0);
                    _loc_4.scaleX = _loc_3.s ? (_loc_3.s) : (1);
                    _loc_4.mouseEnabled = false;
                    this._swfSprite.addChild(_loc_4);
                    this.swfvmcs[_loc_3] = _loc_4;
                    continue;
                }
                if ((_loc_3.name as String).search(".swf") != -1)
                {
                    VResManager.load(MAP_MAPRES_PATH + "swf/" + _loc_3.name, this.__showSwf, [_loc_3]);
                }
            }
            return;
        }// end function

        private function showOneEffect(param1:VMCView) : void
        {
            param1.loadRes(param1.url, null, false, null, null, null, null, FrameworkGlobal.LOAD_MAP_EFFECT);
            param1.auto = true;
            return;
        }// end function

        private function __showSwf(param1, param2:Object) : void
        {
            var _loc_3:* = null;
            _loc_3 = param1;
            if (_loc_3 == null)
            {
                return;
            }
            _loc_3.x = param2.x;
            _loc_3.y = param2.y;
            _loc_3.play();
            if (!this._swfSprite)
            {
                return;
            }
            this._swfSprite.addChild(_loc_3);
            this.swfvmcs[param2] = _loc_3;
            return;
        }// end function

        protected function showbgEffectMask(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 100;
            if (!swfm)
            {
                return;
            }
            for each (_loc_4 in swfm)
            {
                
                if (-param1 - _loc_3 > _loc_4.x || -param1 + FrameworkGlobal.stageW + _loc_3 < _loc_4.x || -param2 - _loc_3 > _loc_4.y || -param2 + _loc_3 + FrameworkGlobal.stageH < _loc_4.y)
                {
                    if (this.maskpng[_loc_4] && this.maskpng[_loc_4].parent)
                    {
                        this._maskSprite.removeChild(this.maskpng[_loc_4]);
                    }
                    this.maskpng[_loc_4] = null;
                    continue;
                }
                if (this.maskpng[_loc_4])
                {
                    continue;
                }
                if ((_loc_4.name as String).search(".png") != -1 || (_loc_4.name as String).search(".jpg") != -1)
                {
                    _loc_5 = new Image();
                    _loc_5.load(MAP_MAPRES_PATH + "swfmask/" + _loc_4.name);
                    _loc_5.move(_loc_4.x, _loc_4.y);
                    _loc_5.rotation = _loc_4.r ? (_loc_4.r) : (0);
                    _loc_5.scaleX = _loc_4.s ? (_loc_4.s) : (1);
                    this._maskSprite.addChild(_loc_5);
                    this.maskpng[_loc_4] = _loc_5;
                }
            }
            return;
        }// end function

        public function addedSkillBgEffect(param1:String, param2:int, param3:int, param4:Number) : Boolean
        {
            var _loc_5:* = null;
            if (!this._skillbgEffect[param4])
            {
                _loc_5 = new VMCView();
                _loc_5.loadRes("art/res/skill/" + param1 + ".png");
                _loc_5.move(param2, param3);
                _loc_5.auto = true;
                _loc_5.updatePose("90", true);
                this._skillbgEffect[param4] = _loc_5;
                this._skillBgContain.addChild(_loc_5);
                return true;
            }
            return false;
        }// end function

        public function removeSkillBgEffect(param1:Number) : Boolean
        {
            var _loc_2:* = this._skillbgEffect[param1];
            if (_loc_2)
            {
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
                _loc_2.stop();
                this._skillbgEffect[param1] = null;
                delete this._skillbgEffect[param1];
                return true;
            }
            return false;
        }// end function

        override public function reset() : void
        {
            TweenLite.killTweensOf(this.showOneEffect);
            if (this.needLoadURLs && this.needLoadURLs.length > 0)
            {
                VResManager.getInstance().cancelLoads(this.needLoadURLs, this.addOneFragmentComplete);
            }
            ToolKit.clearMcChild(this._swfSprite);
            ToolKit.clearMcChild(this._skillBgContain);
            ToolKit.clearMcChild(this._maskSprite);
            super.reset();
            addChild(this._swfSprite);
            addChild(this._skillBgContain);
            addChild(this._maskSprite);
            this.smalls = new Dictionary();
            this.fragments = [];
            this.bmps = new Dictionary();
            this.swfvmcs = new Dictionary();
            this._skillbgEffect = new Dictionary();
            this.maskpng = new Dictionary();
            this.needLoadURLs = [];
            this.idxX = 0;
            this.idxY = 0;
            this.idxX1 = 0;
            this.idxY1 = 0;
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killTweensOf(this.showOneEffect);
            super.finalize();
            this._swfSprite.finalize();
            this._skillBgContain.finalize();
            this._maskSprite.finalize();
            this.fragments = null;
            this.bmps = null;
            this.swfvmcs = null;
            this.maskpng = null;
            FrameworkGlobal.removeMsgListen("showBgEffect", this.__showorHideGgEffect);
            FrameworkGlobal.removeMsgListen("hideBgEffect", this.__showorHideGgEffect);
            return;
        }// end function

    }
}
