﻿package starling.core
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;

    public class Starling extends EventDispatcher
    {
        private var mStage3D:Stage3D;
        private var mStage:Stage;
        private var mRootClass:Class;
        private var mRoot:DisplayObject;
        private var mJuggler:Juggler;
        private var mSupport:RenderSupport;
        private var mTouchProcessor:TouchProcessor;
        private var mAntiAliasing:int;
        private var mSimulateMultitouch:Boolean;
        private var mEnableErrorChecking:Boolean;
        private var mLastFrameTimestamp:Number;
        private var mLeftMouseDown:Boolean;
        private var mStatsDisplay:StatsDisplay;
        private var mShareContext:Boolean;
        private var mProfile:String;
        private var mSupportHighResolutions:Boolean;
        private var mContext:Context3D;
        private var mStarted:Boolean;
        private var mRendering:Boolean;
        private var mViewPort:Rectangle;
        private var mPreviousViewPort:Rectangle;
        private var mClippedViewPort:Rectangle;
        private var mNativeStage:Stage;
        private var mNativeOverlay:Sprite;
        private var mNativeStageContentScaleFactor:Number;
        public static const VERSION:String = "1.4";
        private static const PROGRAM_DATA_NAME:String = "Starling.programs";
        private static var sCurrent:Starling;
        private static var sHandleLostContext:Boolean;
        private static var sContextData:Dictionary = new Dictionary(true);

        public function Starling(param1:Class, param2:Stage, param3:Rectangle = null, param4:Stage3D = null, param5:String = "auto", param6:String = "baselineConstrained")
        {
            var requestContext3D:Function;
            var rootClass:* = param1;
            var stage:* = param2;
            var viewPort:* = param3;
            var stage3D:* = param4;
            var renderMode:* = param5;
            var profile:* = param6;
            if (stage == null)
            {
                throw new ArgumentError("Stage must not be null");
            }
            if (rootClass == null)
            {
                throw new ArgumentError("Root class must not be null");
            }
            if (viewPort == null)
            {
                viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            }
            if (stage3D == null)
            {
                stage3D = stage.stage3Ds[0];
            }
            this.makeCurrent();
            this.mRootClass = rootClass;
            this.mViewPort = viewPort;
            this.mPreviousViewPort = new Rectangle();
            this.mStage3D = stage3D;
            this.mStage = new Stage(viewPort.width, viewPort.height, stage.color);
            this.mNativeOverlay = new Sprite();
            this.mNativeStage = stage;
            this.mNativeStage.addChild(this.mNativeOverlay);
            this.mNativeStageContentScaleFactor = 1;
            this.mTouchProcessor = new TouchProcessor(this.mStage);
            this.mJuggler = new Juggler();
            this.mAntiAliasing = 0;
            this.mSimulateMultitouch = false;
            this.mEnableErrorChecking = false;
            this.mProfile = profile;
            this.mSupportHighResolutions = false;
            this.mLastFrameTimestamp = getTimer() / 1000;
            this.mSupport = new RenderSupport();
            sContextData[stage3D] = new Dictionary();
            sContextData[stage3D][PROGRAM_DATA_NAME] = new Dictionary();
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            this.mStage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated, false, 10, true);
            this.mStage3D.addEventListener(ErrorEvent.ERROR, this.onStage3DError, false, 10, true);
            if (this.mStage3D.context3D && this.mStage3D.context3D.driverInfo != "Disposed")
            {
                this.mShareContext = true;
                setTimeout(this.initialize, 1);
            }
            else
            {
                this.mShareContext = false;
                try
                {
                    requestContext3D = this.mStage3D.requestContext3D;
                    if (requestContext3D.length == 1)
                    {
                        this.requestContext3D(renderMode);
                    }
                    else
                    {
                        this.requestContext3D(renderMode, profile);
                    }
                }
                catch (e:Error)
                {
                    showFatalError("Context3D error: " + e.message);
                }
            }
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.stop(true);
            this.mNativeStage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame, false);
            this.mNativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKey, false);
            this.mNativeStage.removeEventListener(KeyboardEvent.KEY_UP, this.onKey, false);
            this.mNativeStage.removeEventListener(Event.RESIZE, this.onResize, false);
            this.mNativeStage.removeEventListener(Event.MOUSE_LEAVE, this.onMouseLeave, false);
            this.mNativeStage.removeChild(this.mNativeOverlay);
            this.mStage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated, false);
            this.mStage3D.removeEventListener(ErrorEvent.ERROR, this.onStage3DError, false);
            for each (_loc_1 in this.touchEventTypes)
            {
                
                this.mNativeStage.removeEventListener(_loc_1, this.onTouch, false);
            }
            if (this.mStage)
            {
                this.mStage.dispose();
            }
            if (this.mSupport)
            {
                this.mSupport.dispose();
            }
            if (this.mTouchProcessor)
            {
                this.mTouchProcessor.dispose();
            }
            if (sCurrent == this)
            {
                sCurrent = null;
            }
            if (this.mContext && !this.mShareContext)
            {
                _loc_2 = this.mContext.dispose;
                if (_loc_2.length == 1)
                {
                    this._loc_2(false);
                }
                else
                {
                    this._loc_2();
                }
            }
            return;
        }// end function

        private function initialize() : void
        {
            this.makeCurrent();
            this.initializeGraphicsAPI();
            this.initializeRoot();
            this.mTouchProcessor.simulateMultitouch = this.mSimulateMultitouch;
            this.mLastFrameTimestamp = getTimer() / 1000;
            return;
        }// end function

        private function initializeGraphicsAPI() : void
        {
            this.mContext = this.mStage3D.context3D;
            this.mContext.enableErrorChecking = this.mEnableErrorChecking;
            this.contextData[PROGRAM_DATA_NAME] = new Dictionary();
            this.updateViewPort(true);
            trace("[Starling] Initialization complete.");
            trace("[Starling] Display Driver:", this.mContext.driverInfo);
            dispatchEventWith(Event.CONTEXT3D_CREATE, false, this.mContext);
            return;
        }// end function

        private function initializeRoot() : void
        {
            if (this.mRoot == null)
            {
                this.mRoot = new this.mRootClass() as DisplayObject;
                if (this.mRoot == null)
                {
                    throw new Error("Invalid root class: " + this.mRootClass);
                }
                this.mStage.addChildAt(this.mRoot, 0);
                dispatchEventWith(Event.ROOT_CREATED, false, this.mRoot);
            }
            return;
        }// end function

        public function nextFrame() : void
        {
            var _loc_1:* = getTimer() / 1000;
            var _loc_2:* = _loc_1 - this.mLastFrameTimestamp;
            this.mLastFrameTimestamp = _loc_1;
            this.advanceTime(_loc_2);
            this.render();
            return;
        }// end function

        public function advanceTime(param1:Number) : void
        {
            this.makeCurrent();
            this.mTouchProcessor.advanceTime(param1);
            this.mStage.advanceTime(param1);
            this.mJuggler.advanceTime(param1);
            return;
        }// end function

        public function render() : void
        {
            if (!this.contextValid)
            {
                return;
            }
            this.makeCurrent();
            this.updateViewPort();
            this.updateNativeOverlay();
            this.mSupport.nextFrame();
            if (!this.mShareContext)
            {
                RenderSupport.clear(this.mStage.color, 1);
            }
            var _loc_1:* = this.mViewPort.width / this.mStage.stageWidth;
            var _loc_2:* = this.mViewPort.height / this.mStage.stageHeight;
            this.mContext.setDepthTest(false, Context3DCompareMode.ALWAYS);
            this.mContext.setCulling(Context3DTriangleFace.NONE);
            this.mSupport.renderTarget = null;
            this.mSupport.setOrthographicProjection(this.mViewPort.x < 0 ? ((-this.mViewPort.x) / _loc_1) : (0), this.mViewPort.y < 0 ? ((-this.mViewPort.y) / _loc_2) : (0), this.mClippedViewPort.width / _loc_1, this.mClippedViewPort.height / _loc_2);
            this.mStage.render(this.mSupport, 1);
            this.mSupport.finishQuadBatch();
            if (this.mStatsDisplay)
            {
                this.mStatsDisplay.drawCount = this.mSupport.drawCount;
            }
            if (!this.mShareContext)
            {
                this.mContext.present();
            }
            return;
        }// end function

        private function updateViewPort(param1:Boolean = false) : void
        {
            if (param1 || this.mPreviousViewPort.width != this.mViewPort.width || this.mPreviousViewPort.height != this.mViewPort.height || this.mPreviousViewPort.x != this.mViewPort.x || this.mPreviousViewPort.y != this.mViewPort.y)
            {
                this.mPreviousViewPort.setTo(this.mViewPort.x, this.mViewPort.y, this.mViewPort.width, this.mViewPort.height);
                this.mClippedViewPort = this.mViewPort.intersection(new Rectangle(0, 0, this.mNativeStage.stageWidth, this.mNativeStage.stageHeight));
                if (!this.mShareContext)
                {
                    if (this.mProfile == "baselineConstrained")
                    {
                        this.configureBackBuffer(32, 32, this.mAntiAliasing, false);
                    }
                    this.mStage3D.x = this.mClippedViewPort.x;
                    this.mStage3D.y = this.mClippedViewPort.y;
                    this.configureBackBuffer(this.mClippedViewPort.width, this.mClippedViewPort.height, this.mAntiAliasing, false, this.mSupportHighResolutions);
                    if (this.mSupportHighResolutions && "contentsScaleFactor" in this.mNativeStage)
                    {
                        this.mNativeStageContentScaleFactor = this.mNativeStage["contentsScaleFactor"];
                    }
                    else
                    {
                        this.mNativeStageContentScaleFactor = 1;
                    }
                }
            }
            return;
        }// end function

        private function configureBackBuffer(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean = false) : void
        {
            var _loc_6:* = this.mContext.configureBackBuffer;
            var _loc_7:* = [param1, param2, param3, param4];
            if (_loc_6.length > 4)
            {
                _loc_7.push(param5);
            }
            _loc_6.apply(this.mContext, _loc_7);
            return;
        }// end function

        private function updateNativeOverlay() : void
        {
            this.mNativeOverlay.x = this.mViewPort.x;
            this.mNativeOverlay.y = this.mViewPort.y;
            this.mNativeOverlay.scaleX = this.mViewPort.width / this.mStage.stageWidth;
            this.mNativeOverlay.scaleY = this.mViewPort.height / this.mStage.stageHeight;
            return;
        }// end function

        private function showFatalError(param1:String) : void
        {
            var _loc_2:* = new TextField();
            var _loc_3:* = new TextFormat("Verdana", 12, 16777215);
            _loc_3.align = TextFormatAlign.CENTER;
            _loc_2.defaultTextFormat = _loc_3;
            _loc_2.wordWrap = true;
            _loc_2.width = this.mStage.stageWidth * 0.75;
            _loc_2.autoSize = TextFieldAutoSize.CENTER;
            _loc_2.text = param1;
            _loc_2.x = (this.mStage.stageWidth - _loc_2.width) / 2;
            _loc_2.y = (this.mStage.stageHeight - _loc_2.height) / 2;
            _loc_2.background = true;
            _loc_2.backgroundColor = 4456448;
            this.nativeOverlay.addChild(_loc_2);
            return;
        }// end function

        public function makeCurrent() : void
        {
            sCurrent = this;
            return;
        }// end function

        public function start() : void
        {
            var _loc_1:* = true;
            this.mRendering = true;
            this.mStarted = _loc_1;
            this.mLastFrameTimestamp = getTimer() / 1000;
            return;
        }// end function

        public function stop(param1:Boolean = false) : void
        {
            this.mStarted = false;
            this.mRendering = !param1;
            return;
        }// end function

        private function onStage3DError(event:ErrorEvent) : void
        {
            var _loc_2:* = null;
            if (event.errorID == 3702)
            {
                _loc_2 = Capabilities.playerType == "Desktop" ? ("renderMode") : ("wmode");
                this.showFatalError("Context3D not available! Possible reasons: wrong " + _loc_2 + " or missing device support.");
            }
            else
            {
                this.showFatalError("Stage3D error: " + event.text);
            }
            return;
        }// end function

        private function onContextCreated(event:Event) : void
        {
            if (!Starling.handleLostContext && this.mContext)
            {
                this.stop();
                event.stopImmediatePropagation();
                this.showFatalError("Fatal error: The application lost the device context!");
                trace("[Starling] The device context was lost. " + "Enable \'Starling.handleLostContext\' to avoid this error.");
            }
            else
            {
                this.initialize();
            }
            return;
        }// end function

        public function enterframe() : void
        {
            this.onEnterFrame(null);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            if (!this.mShareContext)
            {
                if (this.mStarted)
                {
                    this.nextFrame();
                }
                else if (this.mRendering)
                {
                    this.render();
                }
            }
            return;
        }// end function

        private function onKey(event:KeyboardEvent) : void
        {
            if (!this.mStarted)
            {
                return;
            }
            var _loc_2:* = new KeyboardEvent(event.type, event.charCode, event.keyCode, event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey);
            this.makeCurrent();
            this.mStage.broadcastEvent(_loc_2);
            if (_loc_2.isDefaultPrevented())
            {
                event.preventDefault();
            }
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            var _loc_2:* = event.target as Stage;
            this.mStage.dispatchEvent(new ResizeEvent(Event.RESIZE, _loc_2.stageWidth, _loc_2.stageHeight));
            return;
        }// end function

        private function onMouseLeave(event:Event) : void
        {
            this.mTouchProcessor.enqueueMouseLeftStage();
            return;
        }// end function

        private function onTouch(event:Event) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (!this.mStarted)
            {
                return;
            }
            var _loc_6:* = 1;
            var _loc_7:* = 1;
            var _loc_8:* = 1;
            if (event is MouseEvent)
            {
                _loc_9 = event as MouseEvent;
                _loc_2 = _loc_9.stageX;
                _loc_3 = _loc_9.stageY;
                _loc_4 = 0;
                if (event.type == MouseEvent.MOUSE_DOWN)
                {
                    this.mLeftMouseDown = true;
                }
                else if (event.type == MouseEvent.MOUSE_UP)
                {
                    this.mLeftMouseDown = false;
                }
            }
            else
            {
                _loc_10 = event as TouchEvent;
                if (Mouse.supportsCursor && _loc_10.isPrimaryTouchPoint)
                {
                    return;
                }
                _loc_2 = _loc_10.stageX;
                _loc_3 = _loc_10.stageY;
                _loc_4 = _loc_10.touchPointID;
                _loc_6 = _loc_10.pressure;
                _loc_7 = _loc_10.sizeX;
                _loc_8 = _loc_10.sizeY;
            }
            switch(event.type)
            {
                case TouchEvent.TOUCH_BEGIN:
                {
                    _loc_5 = TouchPhase.BEGAN;
                    break;
                }
                case TouchEvent.TOUCH_MOVE:
                {
                    _loc_5 = TouchPhase.MOVED;
                    break;
                }
                case TouchEvent.TOUCH_END:
                {
                    _loc_5 = TouchPhase.ENDED;
                    break;
                }
                case MouseEvent.MOUSE_DOWN:
                {
                    _loc_5 = TouchPhase.BEGAN;
                    break;
                }
                case MouseEvent.MOUSE_UP:
                {
                    _loc_5 = TouchPhase.ENDED;
                    break;
                }
                case MouseEvent.MOUSE_MOVE:
                {
                    _loc_5 = this.mLeftMouseDown ? (TouchPhase.MOVED) : (TouchPhase.HOVER);
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2 = this.mStage.stageWidth * (_loc_2 - this.mViewPort.x) / this.mViewPort.width;
            _loc_3 = this.mStage.stageHeight * (_loc_3 - this.mViewPort.y) / this.mViewPort.height;
            this.mTouchProcessor.enqueue(_loc_4, _loc_5, _loc_2, _loc_3, _loc_6, _loc_7, _loc_8);
            if (event.type == MouseEvent.MOUSE_UP)
            {
                this.mTouchProcessor.enqueue(_loc_4, TouchPhase.HOVER, _loc_2, _loc_3);
            }
            return;
        }// end function

        private function get touchEventTypes() : Array
        {
            var _loc_1:* = [];
            if (multitouchEnabled)
            {
                _loc_1.push(TouchEvent.TOUCH_BEGIN, TouchEvent.TOUCH_MOVE, TouchEvent.TOUCH_END);
            }
            if (!multitouchEnabled || Mouse.supportsCursor)
            {
                _loc_1.push(MouseEvent.MOUSE_DOWN, MouseEvent.MOUSE_MOVE, MouseEvent.MOUSE_UP);
            }
            return _loc_1;
        }// end function

        public function registerProgram(param1:String, param2:ByteArray, param3:ByteArray) : Program3D
        {
            this.deleteProgram(param1);
            var _loc_4:* = this.mContext.createProgram();
            _loc_4.upload(param2, param3);
            this.programs[param1] = _loc_4;
            return _loc_4;
        }// end function

        public function deleteProgram(param1:String) : void
        {
            var _loc_2:* = this.getProgram(param1);
            if (_loc_2)
            {
                _loc_2.dispose();
                delete this.programs[param1];
            }
            return;
        }// end function

        public function getProgram(param1:String) : Program3D
        {
            return this.programs[param1] as Program3D;
        }// end function

        public function hasProgram(param1:String) : Boolean
        {
            return param1 in this.programs;
        }// end function

        private function get programs() : Dictionary
        {
            return this.contextData[PROGRAM_DATA_NAME];
        }// end function

        private function get contextValid() : Boolean
        {
            return this.mContext && this.mContext.driverInfo != "Disposed";
        }// end function

        public function get isStarted() : Boolean
        {
            return this.mStarted;
        }// end function

        public function get juggler() : Juggler
        {
            return this.mJuggler;
        }// end function

        public function get context() : Context3D
        {
            return this.mContext;
        }// end function

        public function get contextData() : Dictionary
        {
            return sContextData[this.mStage3D] as Dictionary;
        }// end function

        public function get backBufferWidth() : int
        {
            return this.mClippedViewPort.width;
        }// end function

        public function get backBufferHeight() : int
        {
            return this.mClippedViewPort.height;
        }// end function

        public function get simulateMultitouch() : Boolean
        {
            return this.mSimulateMultitouch;
        }// end function

        public function set simulateMultitouch(param1:Boolean) : void
        {
            this.mSimulateMultitouch = param1;
            if (this.mContext)
            {
                this.mTouchProcessor.simulateMultitouch = param1;
            }
            return;
        }// end function

        public function get enableErrorChecking() : Boolean
        {
            return this.mEnableErrorChecking;
        }// end function

        public function set enableErrorChecking(param1:Boolean) : void
        {
            this.mEnableErrorChecking = param1;
            if (this.mContext)
            {
                this.mContext.enableErrorChecking = param1;
            }
            return;
        }// end function

        public function get antiAliasing() : int
        {
            return this.mAntiAliasing;
        }// end function

        public function set antiAliasing(param1:int) : void
        {
            if (this.mAntiAliasing != param1)
            {
                this.mAntiAliasing = param1;
                if (this.contextValid)
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }// end function

        public function get viewPort() : Rectangle
        {
            return this.mViewPort;
        }// end function

        public function set viewPort(param1:Rectangle) : void
        {
            this.mViewPort = param1.clone();
            return;
        }// end function

        public function get contentScaleFactor() : Number
        {
            return this.mViewPort.width * this.mNativeStageContentScaleFactor / this.mStage.stageWidth;
        }// end function

        public function get nativeOverlay() : Sprite
        {
            return this.mNativeOverlay;
        }// end function

        public function get showStats() : Boolean
        {
            return this.mStatsDisplay && this.mStatsDisplay.parent;
        }// end function

        public function set showStats(param1:Boolean) : void
        {
            if (param1 == this.showStats)
            {
                return;
            }
            if (param1)
            {
                if (this.mStatsDisplay)
                {
                    this.mStage.addChild(this.mStatsDisplay);
                }
                else
                {
                    this.showStatsAt();
                }
            }
            else
            {
                this.mStatsDisplay.removeFromParent();
            }
            return;
        }// end function

        public function showStatsAt(param1:String = "left", param2:String = "top", param3:Number = 1) : void
        {
            var onRootCreated:Function;
            var stageWidth:int;
            var stageHeight:int;
            var hAlign:* = param1;
            var vAlign:* = param2;
            var scale:* = param3;
            onRootCreated = function () : void
            {
                showStatsAt(hAlign, vAlign, scale);
                removeEventListener(Event.ROOT_CREATED, onRootCreated);
                return;
            }// end function
            ;
            if (this.mContext == null)
            {
                addEventListener(Event.ROOT_CREATED, onRootCreated);
            }
            else
            {
                if (this.mStatsDisplay == null)
                {
                    this.mStatsDisplay = new StatsDisplay();
                    this.mStatsDisplay.touchable = false;
                    this.mStage.addChild(this.mStatsDisplay);
                }
                stageWidth = this.mStage.stageWidth;
                stageHeight = this.mStage.stageHeight;
                var _loc_5:* = scale;
                this.mStatsDisplay.scaleY = scale;
                this.mStatsDisplay.scaleX = _loc_5;
                if (hAlign == HAlign.LEFT)
                {
                    this.mStatsDisplay.x = 0;
                }
                else if (hAlign == HAlign.RIGHT)
                {
                    this.mStatsDisplay.x = stageWidth - this.mStatsDisplay.width;
                }
                else
                {
                    this.mStatsDisplay.x = int((stageWidth - this.mStatsDisplay.width) / 2);
                }
                if (vAlign == VAlign.TOP)
                {
                    this.mStatsDisplay.y = 0;
                }
                else if (vAlign == VAlign.BOTTOM)
                {
                    this.mStatsDisplay.y = stageHeight - this.mStatsDisplay.height;
                }
                else
                {
                    this.mStatsDisplay.y = int((stageHeight - this.mStatsDisplay.height) / 2);
                }
            }
            return;
        }// end function

        public function get stage() : Stage
        {
            return this.mStage;
        }// end function

        public function get stage3D() : Stage3D
        {
            return this.mStage3D;
        }// end function

        public function get nativeStage() : Stage
        {
            return this.mNativeStage;
        }// end function

        public function get root() : DisplayObject
        {
            return this.mRoot;
        }// end function

        public function get shareContext() : Boolean
        {
            return this.mShareContext;
        }// end function

        public function set shareContext(param1:Boolean) : void
        {
            this.mShareContext = param1;
            return;
        }// end function

        public function get profile() : String
        {
            return this.mProfile;
        }// end function

        public function get supportHighResolutions() : Boolean
        {
            return this.mSupportHighResolutions;
        }// end function

        public function set supportHighResolutions(param1:Boolean) : void
        {
            if (this.mSupportHighResolutions != param1)
            {
                this.mSupportHighResolutions = param1;
                if (this.contextValid)
                {
                    this.updateViewPort(true);
                }
            }
            return;
        }// end function

        public function get touchProcessor() : TouchProcessor
        {
            return this.mTouchProcessor;
        }// end function

        public function set touchProcessor(param1:TouchProcessor) : void
        {
            if (param1 != this.mTouchProcessor)
            {
                this.mTouchProcessor.dispose();
                this.mTouchProcessor = param1;
            }
            return;
        }// end function

        public static function get current() : Starling
        {
            return sCurrent;
        }// end function

        public static function get context() : Context3D
        {
            return sCurrent ? (sCurrent.context) : (null);
        }// end function

        public static function get juggler() : Juggler
        {
            return sCurrent ? (sCurrent.juggler) : (null);
        }// end function

        public static function get contentScaleFactor() : Number
        {
            return sCurrent ? (sCurrent.contentScaleFactor) : (1);
        }// end function

        public static function get multitouchEnabled() : Boolean
        {
            return Multitouch.inputMode == MultitouchInputMode.TOUCH_POINT;
        }// end function

        public static function set multitouchEnabled(param1:Boolean) : void
        {
            if (sCurrent)
            {
                throw new IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
            }
            Multitouch.inputMode = param1 ? (MultitouchInputMode.TOUCH_POINT) : (MultitouchInputMode.NONE);
            return;
        }// end function

        public static function get handleLostContext() : Boolean
        {
            return sHandleLostContext;
        }// end function

        public static function set handleLostContext(param1:Boolean) : void
        {
            if (sCurrent)
            {
                throw new IllegalOperationError("\'handleLostContext\' must be set before Starling instance is created");
            }
            sHandleLostContext = param1;
            return;
        }// end function

    }
}
