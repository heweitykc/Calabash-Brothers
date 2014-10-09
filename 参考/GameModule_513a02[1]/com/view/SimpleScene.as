package com.view
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.manager.*;
    import com.f1.utils.*;
    import com.f1.view.mapeditor.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import interfaces.role.*;
    import starling.display.*;
    import starling.textures.*;

    public class SimpleScene extends BaseScene
    {
        protected var _tempLayer:BaseSprite;
        protected var _topLayer:BaseSprite;
        protected var _bottomLayer:BaseSprite;
        protected var _uiManager:UIManager;
        protected var _bgView:IGameBgView;
        protected var _playerRole:IRole;
        protected var _gameLayer:BaseSprite;
        protected var _bloodLayer:BaseSprite;
        protected var _roles:Array;
        protected var _sceneItems:Array;
        protected var _bottomLightFirst:Sprite;
        protected var _bottomLightTwo:Sprite;
        protected var _bottomLightFirst3D:Image;
        protected var _bottomLightTwo3D:Image;
        protected var _lightAlpha:Number;
        protected var _roofLayer:RoofsContainer;
        protected var _loadedFun:Function;
        protected var isShowBottomLight:Boolean = false;
        private var _preFrameTime:uint;
        private var _frameRate:uint;
        private var _checkFrameNum1:uint;
        private var _checkFrameNum2:uint;
        private var _checkMemoryNum1:uint;
        private var _checkMemoryNum2:uint;
        private var interTimeMax:uint;
        protected var layoutCount:uint;
        protected var checkShowCount:uint;
        public static var SHOW_ROLE_ARROUND_PLAYER_NUM:uint = 25;
        private static var systemTime:int = 0;
        private static var _frameCount:int = 1;
        private static var _frameTimer:int;
        private static var newTime:int;
        private static const MAIN_OFFSET_Y:uint = 45;

        public function SimpleScene()
        {
            this.interTimeMax = 1500 / FrameworkGlobal.frameRate;
            if (!GPUManager.GPUEnable)
            {
                this._bgView = new GameBgView();
                addChild(DisplayObject(this._bgView));
            }
            else
            {
                this._bgView = new GameBgGPUView();
                GPUManager.getInstance().add3DChild(DisplayObject(this._bgView));
            }
            this._bottomLayer = createLayer();
            this._gameLayer = createLayer();
            this._bloodLayer = createLayer();
            this._roofLayer = new RoofsContainer();
            addChild(this._roofLayer);
            this._topLayer = createLayer();
            this._tempLayer = createLayer();
            var _loc_1:* = createLayer();
            this._uiManager = new UIManager(_loc_1);
            this._sceneItems = [];
            this._roles = [];
            FrameworkGlobal.addMsgListen("showShadow", this.showBottomLight);
            FrameworkGlobal.addMsgListen("hideShadow", this.hideBottomLight);
            return;
        }// end function

        protected function get bottomLightFirst()
        {
            if (GPUManager.GPUEnable)
            {
                return this._bottomLightFirst3D;
            }
            return this._bottomLightFirst;
        }// end function

        protected function get bottomLightTwo()
        {
            if (GPUManager.GPUEnable)
            {
                return this._bottomLightTwo3D;
            }
            return this._bottomLightTwo;
        }// end function

        protected function set bottomLightFirst(param1) : void
        {
            if (GPUManager.GPUEnable)
            {
                this._bottomLightFirst3D = param1;
            }
            else
            {
                this._bottomLightFirst = param1;
            }
            return;
        }// end function

        protected function set bottomLightTwo(param1) : void
        {
            if (GPUManager.GPUEnable)
            {
                this._bottomLightTwo3D = param1;
            }
            else
            {
                this._bottomLightTwo = param1;
            }
            return;
        }// end function

        public function get tempLayer() : BaseSprite
        {
            return this._tempLayer;
        }// end function

        public function get bottomLayer() : BaseSprite
        {
            return this._bottomLayer;
        }// end function

        public function get bgView() : IGameBgView
        {
            return this._bgView;
        }// end function

        public function get gameLayer() : BaseSprite
        {
            return this._gameLayer;
        }// end function

        public function get bloodLayer() : BaseSprite
        {
            return this._bloodLayer;
        }// end function

        public function get topLayer() : BaseSprite
        {
            return this._topLayer;
        }// end function

        protected function updateMap(param1:String) : void
        {
            this._bgView.update(param1, this.mapReady, _progressFun);
            return;
        }// end function

        protected function mapReady() : void
        {
            updateWH();
            this.enableEnterFrame();
            if (this._loadedFun != null)
            {
                this._loadedFun();
            }
            if (this._bgView is GameBgView)
            {
                this._roofLayer.setRoofs((this._bgView as GameBgView).roofs);
            }
            else if (this._bgView is GameBgGPUView)
            {
                this._roofLayer.setRoofs((this._bgView as GameBgGPUView).roofs);
            }
            else
            {
                this._roofLayer.setRoofs(null);
            }
            return;
        }// end function

        protected function addElement(param1:IRoleView) : void
        {
            if (this.isInScene(param1))
            {
                return;
            }
            param1.updatePosition();
            if (param1.actType == Params.ACTION_DEAD)
            {
                param1.setAct(Params.ACTION_DEAD, false, false);
            }
            this._roles.push(param1);
            this._gameLayer.addChild(param1.getSprite());
            return;
        }// end function

        public function removeElement(param1:IRoleView) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = this._roles.indexOf(param1);
                if (_loc_2 != -1)
                {
                    this._roles.splice(_loc_2, 1);
                }
                param1.removeFromParent(true);
            }
            return;
        }// end function

        protected function isInScene(param1:IRoleView) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._roles)
            {
                
                if (_loc_2 && _loc_2.info)
                {
                    if (param1 == _loc_2 && !(param1.info is CutePetInfo))
                    {
                        return true;
                    }
                    if (_loc_2.info is CutePetInfo && param1.info is CutePetInfo)
                    {
                        if (CutePetInfo(_loc_2.info).parentId.equal(CutePetInfo(param1.info).parentId))
                        {
                            return true;
                        }
                        continue;
                    }
                    if (_loc_2.info is MagicBookInfo && param1.info is MagicBookInfo)
                    {
                        if (MagicBookInfo(_loc_2.info).parentId.equal(MagicBookInfo(param1.info).parentId))
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }// end function

        public function addBlood(param1) : void
        {
            this._bloodLayer.addChild(param1);
            return;
        }// end function

        private function __enterFrame(event:Event = null) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            newTime = getTimer();
            if (systemTime == 0)
            {
                systemTime = newTime;
                _frameTimer = Math.round(1000 / FrameworkGlobal.frameRate);
            }
            _frameCount = Math.round((newTime - systemTime) / _frameTimer);
            systemTime = newTime;
            FrameworkGlobal.FPS = FrameworkGlobal.frameRate / _frameCount;
            if (FrameworkGlobal.FPS < 28)
            {
                this._checkFrameNum2 = 0;
                if (!FrameworkGlobal.reduceRender)
                {
                    var _loc_6:* = this;
                    var _loc_7:* = this._checkFrameNum1 + 1;
                    _loc_6._checkFrameNum1 = _loc_7;
                    if (this._checkFrameNum1 > 8)
                    {
                        trace("性能下降---------------------------------------------------");
                        FrameworkGlobal.reduceRender = true;
                        this._checkFrameNum1 = 0;
                        SHOW_ROLE_ARROUND_PLAYER_NUM = 20;
                    }
                }
            }
            else
            {
                this._checkFrameNum1 = 0;
                if (FrameworkGlobal.reduceRender)
                {
                    var _loc_6:* = this;
                    var _loc_7:* = this._checkFrameNum2 + 1;
                    _loc_6._checkFrameNum2 = _loc_7;
                    if (this._checkFrameNum2 > 8)
                    {
                        FrameworkGlobal.reduceRender = false;
                        this._checkFrameNum2 = 0;
                        SHOW_ROLE_ARROUND_PLAYER_NUM = 30;
                    }
                }
            }
            var _loc_2:* = System.totalMemory > 700000000;
            if (_loc_2)
            {
                this._checkMemoryNum2 = 0;
                var _loc_6:* = this;
                var _loc_7:* = this._checkMemoryNum1 + 1;
                _loc_6._checkMemoryNum1 = _loc_7;
                if (this._checkMemoryNum1 > 50)
                {
                    FrameworkGlobal.memoryOut = true;
                    this._checkMemoryNum1 = 0;
                    if (FrameworkGlobal.memoryOut)
                    {
                        FrameworkGlobal.sendMsg(new GameEvent(GameEvent.HIDE_OTHER_PLAYERS));
                    }
                }
            }
            else
            {
                this._checkMemoryNum1 = 0;
                if (FrameworkGlobal.memoryOut)
                {
                    var _loc_6:* = this;
                    var _loc_7:* = this._checkMemoryNum2 + 1;
                    _loc_6._checkMemoryNum2 = _loc_7;
                    if (this._checkMemoryNum2 > 50)
                    {
                        FrameworkGlobal.memoryOut = false;
                        this._checkMemoryNum2 = 0;
                    }
                }
            }
            if (FrameworkGlobal.reduceRender)
            {
                if (FrameworkGlobal.showHighLevelShadow)
                {
                    FrameworkGlobal.sendMsg(new Event("hideShadow"));
                    FrameworkGlobal.showHighLevelShadow = false;
                }
            }
            if (this._playerRole)
            {
                this._playerRole.enterFrame();
                if (this._playerRole.isPathing)
                {
                    this.roleMoveHandler();
                }
            }
            if (GPUManager.GPUEnable)
            {
                GPUManager.getInstance().enterframe();
            }
            var _loc_4:* = [];
            if (this._roles.length > SHOW_ROLE_ARROUND_PLAYER_NUM)
            {
                for each (_loc_3 in this._roles)
                {
                    
                    if (_loc_3)
                    {
                        if (!_loc_3.isUser())
                        {
                            _loc_3.distanceToPlayer = ToolKit.distanceSQ(_loc_3._x, _loc_3._y, this._playerRole._x, this._playerRole._y);
                            _loc_3.enterFrame();
                        }
                    }
                }
                _loc_7.sortOn(["distanceToPlayer", "roleIdLow"], Array.NUMERIC);
                _loc_5 = 0;
                for each (_loc_3 in this._roles)
                {
                    
                    if (_loc_3)
                    {
                        if (!_loc_3.isUser())
                        {
                            if (_loc_3.isStand())
                            {
                                if (_loc_4.indexOf(_loc_3.px + "_" + _loc_3.py) == -1)
                                {
                                    _loc_4.push(_loc_3.px + "_" + _loc_3.py);
                                }
                                else if (!_loc_3.isNPC())
                                {
                                    _loc_3.setVisible(false);
                                    continue;
                                }
                            }
                            if (!_loc_3.isMonster() || _loc_5 <= SHOW_ROLE_ARROUND_PLAYER_NUM)
                            {
                                if (UICfg.hideOtherPlayer && _loc_3.isPlayer() || UICfg.NORMAL_MONSTER && _loc_3.info.monster_type == 1)
                                {
                                    continue;
                                }
                                _loc_5 = _loc_5 + 1;
                                _loc_3.setVisible(true);
                                continue;
                            }
                            if (!_loc_3.isNPC())
                            {
                                _loc_3.setVisible(false);
                            }
                        }
                    }
                }
            }
            else
            {
                for each (_loc_3 in this._roles)
                {
                    
                    if (_loc_3)
                    {
                        if (!_loc_3.isUser())
                        {
                            _loc_3.enterFrame();
                            if (UICfg.hideOtherPlayer && _loc_3.isPlayer() || UICfg.NORMAL_MONSTER && _loc_3.info.monster_type == 1)
                            {
                                continue;
                            }
                            _loc_3.setVisible(true);
                        }
                    }
                }
            }
            var _loc_6:* = this;
            _loc_6.layoutCount = this.layoutCount + 1;
            if (this.layoutCount++ > 8)
            {
                this.layoutElements();
                this.layoutCount = 0;
            }
            return;
        }// end function

        private function layoutElements() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = this._roles;
            if (_loc_1 && _loc_1.length > 1)
            {
                _loc_1.sortOn(["y", "roleIdLow"], Array.NUMERIC);
                _loc_2 = _loc_1.length;
                while (_loc_2--)
                {
                    
                    display = _loc_1[_loc_2];
                    if (display)
                    {
                        if (display.parent == this._gameLayer)
                        {
                            if (this._gameLayer.numChildren > _loc_2)
                            {
                                if (this._gameLayer.getChildIndex(display) != _loc_2)
                                {
                                    this._gameLayer.setChildIndex(display, _loc_2);
                                }
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function roleMoveHandler() : void
        {
            if (this._gameLayer == null)
            {
                return;
            }
            if (this._playerRole == null)
            {
                return;
            }
            var _loc_1:* = this._playerRole.getSprite();
            var _loc_2:* = _loc_1.x;
            var _loc_3:* = _loc_1.y - MAIN_OFFSET_Y;
            this.moveScene(_loc_2, _loc_3);
            return;
        }// end function

        public function moveScene(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = this._bgView._w;
            var _loc_6:* = this._bgView._h;
            var _loc_7:* = _w * 0.47;
            var _loc_8:* = _h * 0.48;
            var _loc_9:* = param1 + this._gameLayer.x;
            var _loc_10:* = param2 + this._gameLayer.y;
            var _loc_11:* = _w;
            var _loc_12:* = _h;
            var _loc_13:* = this._gameLayer.x;
            var _loc_14:* = this._gameLayer.y;
            if (_loc_5 > _w)
            {
                if (_loc_9 < _loc_7)
                {
                    _loc_3 = _loc_9 - _loc_7;
                }
                else if (_loc_9 > _loc_11 - _loc_7)
                {
                    _loc_3 = _loc_9 - _loc_11 + _loc_7;
                }
                else
                {
                    _loc_3 = 0;
                }
                if (_loc_3 != 0)
                {
                    if (_loc_3 - _loc_13 <= 0)
                    {
                        _loc_13 = 0;
                    }
                    else if (_loc_3 - _loc_13 >= _loc_5 - _loc_11)
                    {
                        _loc_13 = _loc_11 - _loc_5;
                    }
                    else
                    {
                        _loc_13 = _loc_13 - _loc_3;
                    }
                }
            }
            if (_loc_6 > _h)
            {
                if (_loc_10 < _loc_8)
                {
                    _loc_4 = _loc_10 - _loc_8;
                }
                else if (_loc_10 > _loc_12 - _loc_8)
                {
                    _loc_4 = _loc_10 - _loc_12 + _loc_8;
                }
                else
                {
                    _loc_4 = 0;
                }
                if (_loc_4 != 0)
                {
                    if (_loc_4 - _loc_14 <= 0)
                    {
                        _loc_14 = 0;
                    }
                    else if (_loc_4 - _loc_14 >= _loc_6 - _loc_12)
                    {
                        _loc_14 = _loc_12 - _loc_6;
                    }
                    else
                    {
                        _loc_14 = _loc_14 - _loc_4;
                    }
                }
            }
            this._bgView.move(_loc_13, _loc_14);
            this._gameLayer.move(_loc_13, _loc_14);
            this._bloodLayer.move(_loc_13, _loc_14);
            this._topLayer.move(_loc_13, _loc_14);
            this._bottomLayer.move(_loc_13, _loc_14);
            this._tempLayer.move(_loc_13, _loc_14);
            this._roofLayer.move(_loc_13, _loc_14);
            this.changeLightPosition();
            return;
        }// end function

        public function enableEnterFrame() : void
        {
            addEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            return;
        }// end function

        public function disableEnterFrame() : void
        {
            removeEventListener(Event.ENTER_FRAME, this.__enterFrame);
            return;
        }// end function

        protected function showBottomLight(event:Event) : void
        {
            if (this._playerRole && this._playerRole.isUser())
            {
                this.isShowBottomLight = true;
                this.makeBottomLight();
            }
            return;
        }// end function

        public function hideBottomLight(event:Event) : void
        {
            if (this._playerRole && this._playerRole.isUser())
            {
                this.isShowBottomLight = false;
                if (this.bottomLightFirst && this.bottomLightFirst.parent)
                {
                    this.bottomLightFirst.parent.removeChild(this.bottomLightFirst);
                }
                if (this.bottomLightTwo && this.bottomLightTwo.parent)
                {
                    this.bottomLightTwo.parent.removeChild(this.bottomLightTwo);
                }
            }
            return;
        }// end function

        protected function changeLightPosition() : void
        {
            if (this.bottomLightFirst)
            {
                this.bottomLightFirst.x = this._gameLayer.x + this._playerRole._x - 125;
                this.bottomLightFirst.y = this._gameLayer.y + this._playerRole._y - 80;
            }
            if (this.bottomLightTwo && this.bottomLightTwo.parent)
            {
                this.bottomLightTwo.x = this._gameLayer.x + this._playerRole._x - 125;
                this.bottomLightTwo.y = this._gameLayer.y + this._playerRole._y - 80;
            }
            return;
        }// end function

        private function creatBottomLight(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (GPUManager.GPUEnable)
            {
                if (!param1)
                {
                    _loc_2 = ToolKit.getNew("bottomLightBMD");
                    _loc_3 = Texture.fromBitmapData(_loc_2, false);
                    param1 = new Image(_loc_3);
                    param1.blendMode = BlendMode.ADD;
                }
                GPUManager.getInstance().add3DChild(param1);
            }
            else
            {
                if (!param1)
                {
                    param1 = ToolKit.getNew("bottomLight");
                    param1.blendMode = BlendMode.ADD;
                    param1.mouseEnabled = false;
                    param1.mouseChildren = false;
                }
                addChildAt(param1, 1);
            }
            return param1;
        }// end function

        private function makeBottomLight() : void
        {
            return;
        }// end function

        protected function changeLightStreng(param1:uint) : void
        {
            if (this.bottomLightFirst)
            {
                var _loc_2:* = MapCfgObj.getInstance().getMap(param1).q_light_intensity / 100;
                this.bottomLightFirst.alpha = MapCfgObj.getInstance().getMap(param1).q_light_intensity / 100;
                this._lightAlpha = _loc_2;
                this.bottomLightFirst.alpha = this._lightAlpha;
            }
            return;
        }// end function

        public function getMapXY(param1:int, param2:int) : Array
        {
            return [param1 + this._gameLayer.x, param2 + this._gameLayer.y];
        }// end function

        protected function showLoginEff(param1:IBaseSprite) : void
        {
            return;
        }// end function

        override public function setScale(param1:Number) : void
        {
            super.setScale(param1);
            if (GPUManager.GPUEnable)
            {
                this._bgView.setScale(param1);
            }
            return;
        }// end function

        public function reset() : void
        {
            this._roles = [];
            this._sceneItems = [];
            this._bgView.reset();
            this._roofLayer.reset();
            return;
        }// end function

        public function addFilterToMap(param1:Array) : void
        {
            if (this._bgView)
            {
                this._bgView.setFilters(param1);
            }
            return;
        }// end function

        override public function resize() : void
        {
            super.resize();
            this._bgView.resize();
            this.roleMoveHandler();
            return;
        }// end function

        override public function finalize() : void
        {
            this.disableEnterFrame();
            this._bgView.finalize();
            this._bgView = null;
            this._roofLayer.finalize();
            super.finalize();
            return;
        }// end function

        public function isAtScene(param1:Number, param2:Number) : Boolean
        {
            var _loc_3:* = 70;
            var _loc_4:* = 30;
            return param1 + this._bgView.x >= _loc_3 && param1 + this._bgView.x < _w - _loc_3 && param2 + this._bgView.y >= _loc_4 && param2 + this._bgView.y < _h - _loc_4;
        }// end function

    }
}
