package com.f1.view.mapeditor
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.manager.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.f1.vmc.gpu.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;

    public class GameBgGPUView extends BgGPUView implements IGameBgView
    {
        private var fragments:Array;
        private var bmps:Dictionary;
        private var _tileContainer:BaseGPUSprite;
        private var _swfSprite:BaseGPUSprite;
        private var _maskSprite:BaseGPUSprite;
        private var currentbgEffectSwfs:Array;
        private var swfvmcs:Dictionary;
        private var currentbgMask:Array;
        private var maskpng:Dictionary;
        private var _skillbgEffect:Dictionary;
        private var _skillBgContain:BaseGPUSprite;
        private var idxX:uint;
        private var idxY:uint;
        private var idxX1:uint;
        private var idxY1:uint;
        private var needLoadURLs:Array;
        private var checkEffectCount:uint = 999;
        private var _loadingNum:int;
        private var smallTexture:Texture;

        public function GameBgGPUView()
        {
            this.needLoadURLs = [];
            this._swfSprite = new BaseGPUSprite();
            this._skillBgContain = new BaseGPUSprite();
            this._maskSprite = new BaseGPUSprite();
            this._tileContainer = new BaseGPUSprite();
            this._tileContainer.touchable = false;
            this._swfSprite.touchable = false;
            this._skillBgContain.touchable = false;
            this._maskSprite.touchable = false;
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
                this._skillBgContain.finalize();
                this._maskSprite.finalize();
            }
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            super.move(param1, param2);
            this.updateFragment(param1, param2);
            var _loc_3:* = this;
            _loc_3.checkEffectCount = this.checkEffectCount + 1;
            if (this.checkEffectCount++ > 5)
            {
                this.checkEffectCount = 0;
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
            if (_smallBg)
            {
                this.showSmallFragment(-param1, -param2);
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
                    _loc_13 = bgSrc + "/atf/bgfm" + _loc_9 + ".atf";
                    if (this.fragments.indexOf(_loc_9) == -1)
                    {
                        if (this.needLoadURLs.indexOf(_loc_13) == -1)
                        {
                            _loc_11.push({url:_loc_13, params:[_loc_9, _loc_7, _loc_8], distance:ToolKit.distanceSQ(_loc_14, _loc_15, _loc_7, _loc_8)});
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
                    if (_loc_16)
                    {
                        _loc_16.removeFromParent();
                        _loc_16.texture.dispose();
                        _loc_16.dispose();
                        this.bmps[_loc_9] = null;
                        delete this.bmps[_loc_9];
                    }
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
                this.checkSmallShow();
            }
            return;
        }// end function

        private function startLoadFragment() : void
        {
            var _loc_1:* = null;
            if (this.needLoadURLs && this.needLoadURLs.length > 0)
            {
                _loc_1 = this.needLoadURLs.shift();
                var _loc_2:* = this;
                var _loc_3:* = this._loadingNum + 1;
                _loc_2._loadingNum = _loc_3;
                VResManager.load(_loc_1.url, this.addOneFragmentComplete, _loc_1.params, addOneFragmentFail, null, false, true, false, FrameworkGlobal.LOAD_PRELOAD_MAP);
            }
            return;
        }// end function

        override protected function addOneFragmentComplete(param1:ByteArray, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = this;
            var _loc_6:* = this._loadingNum - 1;
            _loc_5._loadingNum = _loc_6;
            if (this.fragments && this.fragments.length > 0 && this.fragments.indexOf(param2) != -1)
            {
                if (param1)
                {
                    this.showFragmentByATF(param1, param2, param3, param4);
                }
            }
            return;
        }// end function

        protected function showFragmentByBitmapData(param1:BitmapData, param2:int, param3:int, param4:int) : void
        {
            if (!this.bmps)
            {
                return;
            }
            var _loc_5:* = Texture.fromBitmapData(param1, false);
            this.showFragment(_loc_5, param2, param3, param4);
            return;
        }// end function

        override protected function showFragmentByATF(param1:ByteArray, param2:int, param3:int, param4:int) : void
        {
            var texture1:Texture;
            var data:* = param1;
            var index:* = param2;
            var px:* = param3;
            var py:* = param4;
            if (!this.bmps)
            {
                return;
            }
            texture1 = Texture.fromAtfData(data, 1, false, function () : void
            {
                showFragment(texture1, index, px, py);
                if (needLoadURLs.length > 0)
                {
                    startLoadFragment();
                    startLoadFragment();
                }
                return;
            }// end function
            );
            return;
        }// end function

        protected function showFragment(param1:Texture, param2:int, param3:int, param4:int) : void
        {
            if (!this.bmps)
            {
                return;
            }
            var _loc_5:* = this.bmps[param2];
            if (!this.bmps[param2])
            {
                _loc_5 = new Image(param1);
                _loc_5.blendMode = BlendMode.NONE;
                _loc_5.smoothing = TextureSmoothing.NONE;
                _loc_5.width = fragmentWidth;
                _loc_5.height = fragmentHeight;
                _loc_5.x = param3 * fragmentWidth;
                _loc_5.y = param4 * fragmentHeight;
                this._tileContainer.addChild(_loc_5);
                this.bmps[param2] = _loc_5;
                this.checkSmallShow();
            }
            else
            {
                _loc_5.texture = param1;
            }
            return;
        }// end function

        protected function checkSmallShow() : void
        {
            if (this._loadingNum == 0)
            {
                if (_smallBg.parent)
                {
                    _smallBg.removeFromParent();
                }
            }
            else if (_smallBg.parent == null)
            {
                GPUManager.getInstance().add3DChild(_smallBg, 0);
            }
            return;
        }// end function

        override protected function loadSmallBgOK(param1:BitmapData) : void
        {
            this.smallTexture = Texture.fromBitmapData(param1, false);
            if (!_smallBg)
            {
                _smallBg = new Image(this.smallTexture);
                _smallBg.width = FrameworkGlobal.stageW;
                _smallBg.height = FrameworkGlobal.stageH;
                _smallBg.smoothing = TextureSmoothing.NONE;
                _smallBg.blendMode = BlendMode.NONE;
            }
            else
            {
                _smallBg.texture = this.smallTexture;
            }
            return;
        }// end function

        protected function showSmallFragment(param1:Number, param2:Number) : void
        {
            var _loc_3:* = FrameworkGlobal.stageW;
            var _loc_4:* = FrameworkGlobal.stageH;
            _smallBg.setTexCoords(0, new Point(param1 / _w, param2 / _h));
            _smallBg.setTexCoords(1, new Point((param1 + _loc_3) / _w, param2 / _h));
            _smallBg.setTexCoords(2, new Point(param1 / _w, (param2 + _loc_4) / _h));
            _smallBg.setTexCoords(3, new Point((param1 + _loc_3) / _w, (param2 + _loc_4) / _h));
            return;
        }// end function

        protected function showbgEffect(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
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
                            this.swfvmcs[_loc_3].stop();
                            this._swfSprite.removeChild(this.swfvmcs[_loc_3]);
                        }
                        this.swfvmcs[_loc_3] = null;
                        delete this.swfvmcs[_loc_3];
                    }
                    continue;
                }
                if (this.swfvmcs[_loc_3])
                {
                    continue;
                }
                if ((_loc_3.name as String).search(".png") != -1)
                {
                    _loc_4 = new VMCGPUView();
                    _loc_4.url = MAP_MAPRES_PATH + "atf/png/" + _loc_3.name.replace(".png", ".bin");
                    _loc_4.auto = true;
                    if (!_loc_4.updatePose("90", true, true))
                    {
                        TweenLite.delayedCall(15, this.showOneEffect, [_loc_4]);
                    }
                    _loc_4.move(_loc_3.x, _loc_3.y);
                    _loc_4.rotation = _loc_3.r ? (_loc_3.r) : (0);
                    _loc_4.scaleX = _loc_3.s ? (_loc_3.s) : (1);
                    this._swfSprite.addChild(_loc_4);
                    this.swfvmcs[_loc_3] = _loc_4;
                    continue;
                }
                if ((_loc_3.name as String).search(".swf") != -1)
                {
                    VResManager.load(MAP_MAPRES_PATH + "swf/" + _loc_3.name, this.__showSwf, [_loc_3], null, null, false, false, false, -10);
                }
            }
            return;
        }// end function

        private function showOneEffect(param1:VMCGPUView) : void
        {
            param1.loadRes(param1.url, null, false, null, null, null, null, FrameworkGlobal.LOAD_MAP_EFFECT);
            return;
        }// end function

        protected function showbgEffectMask(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 300;
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
                    delete this.maskpng[_loc_4];
                    continue;
                }
                if (this.maskpng[_loc_4])
                {
                    continue;
                }
                if ((_loc_4.name as String).search(".png") != -1 || (_loc_4.name as String).search(".jpg") != -1)
                {
                    VResManager.load(MAP_MAPRES_PATH + "swfmask/" + _loc_4.name, this.__showSwfmask, [_loc_4]);
                }
            }
            return;
        }// end function

        private function __showSwfmask(param1:BitmapData, param2:Object) : void
        {
            var _loc_3:* = Texture.fromBitmapData(param1, false);
            var _loc_4:* = new Image(_loc_3);
            _loc_4.x = param2.x;
            _loc_4.y = param2.y;
            _loc_4.rotation = param2.r ? (param2.r) : (0);
            _loc_4.scaleX = param2.s ? (param2.s) : (1);
            this._maskSprite.addChild(_loc_4);
            this.maskpng[param2] = _loc_4;
            param1.dispose();
            return;
        }// end function

        override protected function addBgFragments() : void
        {
            return;
        }// end function

        private function __showSwf(param1, param2:Object) : void
        {
            return;
        }// end function

        public function addedSkillBgEffect(param1:String, param2:int, param3:int, param4:Number) : Boolean
        {
            var _loc_5:* = null;
            if (!this._skillbgEffect[param4])
            {
                _loc_5 = new VMCGPUView();
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

        override public function resize() : void
        {
            if (_smallBg)
            {
                _smallBg.width = FrameworkGlobal.stageW;
                _smallBg.height = FrameworkGlobal.stageH;
            }
            return;
        }// end function

        override public function reset() : void
        {
            TweenLite.killDelayedCallsTo(this.showOneEffect);
            if (_url)
            {
                VResManager.getInstance().cancelLoad(_url, loadBinComplete);
            }
            if (this.needLoadURLs && this.needLoadURLs.length > 0)
            {
                VResManager.getInstance().cancelLoads(this.needLoadURLs, this.addOneFragmentComplete);
            }
            BaseGPUSprite.clearChild(this._swfSprite);
            BaseGPUSprite.clearChild(this._skillBgContain);
            BaseGPUSprite.clearChild(this._maskSprite);
            BaseGPUSprite.clearChild(this._tileContainer, true);
            addChild(this._tileContainer);
            addChild(this._swfSprite);
            addChild(this._skillBgContain);
            addChild(this._maskSprite);
            this.fragments = [];
            this.bmps = new Dictionary();
            this.currentbgEffectSwfs = [];
            this.swfvmcs = new Dictionary();
            this.currentbgMask = [];
            this.maskpng = new Dictionary();
            this.needLoadURLs = [];
            this.idxX = 0;
            this.idxY = 0;
            this.idxX1 = 0;
            this.idxY1 = 0;
            return;
        }// end function

        override public function removeFromParent(param1:Boolean = false) : void
        {
            super.removeFromParent(param1);
            return;
        }// end function

        override public function finalize() : void
        {
            TweenLite.killDelayedCallsTo(this.showOneEffect);
            super.finalize();
            this._swfSprite.finalize();
            this._skillBgContain.finalize();
            this._maskSprite.finalize();
            this.fragments = null;
            this.bmps = null;
            this.currentbgEffectSwfs = null;
            this.swfvmcs = null;
            this.currentbgMask = null;
            this.maskpng = null;
            FrameworkGlobal.removeMsgListen("showBgEffect", this.__showorHideGgEffect);
            FrameworkGlobal.removeMsgListen("highBgEffect", this.__showorHideGgEffect);
            return;
        }// end function

    }
}
