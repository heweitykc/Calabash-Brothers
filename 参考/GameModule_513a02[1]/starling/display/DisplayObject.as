package starling.display
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.utils.*;

    public class DisplayObject extends EventDispatcher
    {
        private var mX:Number;
        private var mY:Number;
        private var mPivotX:Number;
        private var mPivotY:Number;
        private var mScaleX:Number;
        private var mScaleY:Number;
        private var mSkewX:Number;
        private var mSkewY:Number;
        private var mRotation:Number;
        private var mAlpha:Number;
        private var mVisible:Boolean;
        private var mTouchable:Boolean;
        private var mBlendMode:String;
        private var mName:String;
        private var mUseHandCursor:Boolean;
        private var mParent:DisplayObjectContainer;
        private var mTransformationMatrix:Matrix;
        private var mOrientationChanged:Boolean;
        private var mFilter:FragmentFilter;
        private static var sAncestors:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
        private static var sHelperRect:Rectangle = new Rectangle();
        private static var sHelperMatrix:Matrix = new Matrix();

        public function DisplayObject()
        {
            if (Capabilities.isDebugger && getQualifiedClassName(this) == "starling.display::DisplayObject")
            {
                throw new AbstractClassError();
            }
            var _loc_1:* = 0;
            this.mSkewY = 0;
            this.mSkewX = _loc_1;
            this.mRotation = _loc_1;
            this.mPivotY = _loc_1;
            this.mPivotX = _loc_1;
            this.mY = _loc_1;
            this.mX = _loc_1;
            var _loc_1:* = 1;
            this.mAlpha = 1;
            this.mScaleY = _loc_1;
            this.mScaleX = _loc_1;
            var _loc_1:* = true;
            this.mTouchable = true;
            this.mVisible = _loc_1;
            this.mBlendMode = BlendMode.AUTO;
            this.mTransformationMatrix = new Matrix();
            var _loc_1:* = false;
            this.mUseHandCursor = false;
            this.mOrientationChanged = _loc_1;
            return;
        }// end function

        public function dispose() : void
        {
            if (this.mFilter)
            {
                this.mFilter.dispose();
            }
            this.removeEventListeners();
            return;
        }// end function

        public function removeFromParent(param1:Boolean = false) : void
        {
            if (this.mParent)
            {
                this.mParent.removeChild(this, param1);
            }
            else if (param1)
            {
                this.dispose();
            }
            return;
        }// end function

        public function getTransformationMatrix(param1:DisplayObject, param2:Matrix = null) : Matrix
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param2)
            {
                param2.identity();
            }
            else
            {
                param2 = new Matrix();
            }
            if (param1 == this)
            {
                return param2;
            }
            if (param1 == this.mParent || param1 == null && this.mParent == null)
            {
                param2.copyFrom(this.transformationMatrix);
                return param2;
            }
            if (param1 == null || param1 == this.base)
            {
                _loc_4 = this;
                while (_loc_4 != param1)
                {
                    
                    param2.concat(_loc_4.transformationMatrix);
                    _loc_4 = _loc_4.mParent;
                }
                return param2;
            }
            else if (param1.mParent == this)
            {
                param1.getTransformationMatrix(this, param2);
                param2.invert();
                return param2;
            }
            _loc_3 = null;
            _loc_4 = this;
            while (_loc_4)
            {
                
                sAncestors[sAncestors.length] = _loc_4;
                _loc_4 = _loc_4.mParent;
            }
            _loc_4 = param1;
            while (_loc_4 && sAncestors.indexOf(_loc_4) == -1)
            {
                
                _loc_4 = _loc_4.mParent;
            }
            sAncestors.length = 0;
            if (_loc_4)
            {
                _loc_3 = _loc_4;
            }
            else
            {
                throw new ArgumentError("Object not connected to target");
            }
            _loc_4 = this;
            while (_loc_4 != _loc_3)
            {
                
                param2.concat(_loc_4.transformationMatrix);
                _loc_4 = _loc_4.mParent;
            }
            if (_loc_3 == param1)
            {
                return param2;
            }
            sHelperMatrix.identity();
            _loc_4 = param1;
            while (_loc_4 != _loc_3)
            {
                
                sHelperMatrix.concat(_loc_4.transformationMatrix);
                _loc_4 = _loc_4.mParent;
            }
            sHelperMatrix.invert();
            param2.concat(sHelperMatrix);
            return param2;
        }// end function

        public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
        {
            throw new AbstractMethodError();
        }// end function

        public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
        {
            if (param2 && (!this.mVisible || !this.mTouchable))
            {
                return null;
            }
            if (this.getBounds(this, sHelperRect).containsPoint(param1))
            {
                return this;
            }
            return null;
        }// end function

        public function localToGlobal(param1:Point, param2:Point = null) : Point
        {
            this.getTransformationMatrix(this.base, sHelperMatrix);
            return MatrixUtil.transformCoords(sHelperMatrix, param1.x, param1.y, param2);
        }// end function

        public function globalToLocal(param1:Point, param2:Point = null) : Point
        {
            this.getTransformationMatrix(this.base, sHelperMatrix);
            sHelperMatrix.invert();
            return MatrixUtil.transformCoords(sHelperMatrix, param1.x, param1.y, param2);
        }// end function

        public function render(param1:RenderSupport, param2:Number) : void
        {
            throw new AbstractMethodError();
        }// end function

        public function get hasVisibleArea() : Boolean
        {
            return this.mAlpha != 0 && this.mVisible && this.mScaleX != 0 && this.mScaleY != 0;
        }// end function

        public function alignPivot(param1:String = "center", param2:String = "center") : void
        {
            var _loc_3:* = this.getBounds(this);
            this.mOrientationChanged = true;
            if (param1 == HAlign.LEFT)
            {
                this.mPivotX = _loc_3.x;
            }
            else if (param1 == HAlign.CENTER)
            {
                this.mPivotX = _loc_3.x + _loc_3.width / 2;
            }
            else if (param1 == HAlign.RIGHT)
            {
                this.mPivotX = _loc_3.x + _loc_3.width;
            }
            else
            {
                throw new ArgumentError("Invalid horizontal alignment: " + param1);
            }
            if (param2 == VAlign.TOP)
            {
                this.mPivotY = _loc_3.y;
            }
            else if (param2 == VAlign.CENTER)
            {
                this.mPivotY = _loc_3.y + _loc_3.height / 2;
            }
            else if (param2 == VAlign.BOTTOM)
            {
                this.mPivotY = _loc_3.y + _loc_3.height;
            }
            else
            {
                throw new ArgumentError("Invalid vertical alignment: " + param2);
            }
            return;
        }// end function

        function setParent(param1:DisplayObjectContainer) : void
        {
            var _loc_2:* = param1;
            while (_loc_2 != this && _loc_2 != null)
            {
                
                _loc_2 = _loc_2.mParent;
            }
            if (_loc_2 == this)
            {
                throw new ArgumentError("An object cannot be added as a child to itself or one " + "of its children (or children\'s children, etc.)");
            }
            this.mParent = param1;
            return;
        }// end function

        final private function isEquivalent(param1:Number, param2:Number, param3:Number = 0.0001) : Boolean
        {
            return param1 - param3 < param2 && param1 + param3 > param2;
        }// end function

        final private function normalizeAngle(param1:Number) : Number
        {
            while (param1 < -Math.PI)
            {
                
                param1 = param1 + Math.PI * 2;
            }
            while (param1 > Math.PI)
            {
                
                param1 = param1 - Math.PI * 2;
            }
            return param1;
        }// end function

        override public function addEventListener(param1:String, param2:Function) : void
        {
            if (param1 == Event.ENTER_FRAME && !hasEventListener(param1))
            {
                this.addEventListener(Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                if (this.stage)
                {
                    this.addEnterFrameListenerToStage();
                }
            }
            super.addEventListener(param1, param2);
            return;
        }// end function

        override public function removeEventListener(param1:String, param2:Function) : void
        {
            super.removeEventListener(param1, param2);
            if (param1 == Event.ENTER_FRAME && !hasEventListener(param1))
            {
                this.removeEventListener(Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            return;
        }// end function

        override public function removeEventListeners(param1:String = null) : void
        {
            super.removeEventListeners(param1);
            if (param1 == null || param1 == Event.ENTER_FRAME)
            {
                this.removeEventListener(Event.ADDED_TO_STAGE, this.addEnterFrameListenerToStage);
                this.removeEventListener(Event.REMOVED_FROM_STAGE, this.removeEnterFrameListenerFromStage);
                this.removeEnterFrameListenerFromStage();
            }
            return;
        }// end function

        private function addEnterFrameListenerToStage() : void
        {
            Starling.current.stage.addEnterFrameListener(this);
            return;
        }// end function

        private function removeEnterFrameListenerFromStage() : void
        {
            Starling.current.stage.removeEnterFrameListener(this);
            return;
        }// end function

        public function get transformationMatrix() : Matrix
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (this.mOrientationChanged)
            {
                this.mOrientationChanged = false;
                if (this.mSkewX == 0 && this.mSkewY == 0)
                {
                    if (this.mRotation == 0)
                    {
                        this.mTransformationMatrix.setTo(this.mScaleX, 0, 0, this.mScaleY, this.mX - this.mPivotX * this.mScaleX, this.mY - this.mPivotY * this.mScaleY);
                    }
                    else
                    {
                        _loc_1 = Math.cos(this.mRotation);
                        _loc_2 = Math.sin(this.mRotation);
                        _loc_3 = this.mScaleX * _loc_1;
                        _loc_4 = this.mScaleX * _loc_2;
                        _loc_5 = this.mScaleY * (-_loc_2);
                        _loc_6 = this.mScaleY * _loc_1;
                        _loc_7 = this.mX - this.mPivotX * _loc_3 - this.mPivotY * _loc_5;
                        _loc_8 = this.mY - this.mPivotX * _loc_4 - this.mPivotY * _loc_6;
                        this.mTransformationMatrix.setTo(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8);
                    }
                }
                else
                {
                    this.mTransformationMatrix.identity();
                    this.mTransformationMatrix.scale(this.mScaleX, this.mScaleY);
                    MatrixUtil.skew(this.mTransformationMatrix, this.mSkewX, this.mSkewY);
                    this.mTransformationMatrix.rotate(this.mRotation);
                    this.mTransformationMatrix.translate(this.mX, this.mY);
                    if (this.mPivotX != 0 || this.mPivotY != 0)
                    {
                        this.mTransformationMatrix.tx = this.mX - this.mTransformationMatrix.a * this.mPivotX - this.mTransformationMatrix.c * this.mPivotY;
                        this.mTransformationMatrix.ty = this.mY - this.mTransformationMatrix.b * this.mPivotX - this.mTransformationMatrix.d * this.mPivotY;
                    }
                }
            }
            return this.mTransformationMatrix;
        }// end function

        public function set transformationMatrix(param1:Matrix) : void
        {
            this.mOrientationChanged = false;
            this.mTransformationMatrix.copyFrom(param1);
            var _loc_2:* = 0;
            this.mPivotY = 0;
            this.mPivotX = _loc_2;
            this.mX = param1.tx;
            this.mY = param1.ty;
            this.mScaleX = Math.sqrt(param1.a * param1.a + param1.b * param1.b);
            this.mSkewY = Math.acos(param1.a / this.mScaleX);
            if (!this.isEquivalent(param1.b, this.mScaleX * Math.sin(this.mSkewY)))
            {
                this.mScaleX = this.mScaleX * -1;
                this.mSkewY = Math.acos(param1.a / this.mScaleX);
            }
            this.mScaleY = Math.sqrt(param1.c * param1.c + param1.d * param1.d);
            this.mSkewX = Math.acos(param1.d / this.mScaleY);
            if (!this.isEquivalent(param1.c, (-this.mScaleY) * Math.sin(this.mSkewX)))
            {
                this.mScaleY = this.mScaleY * -1;
                this.mSkewX = Math.acos(param1.d / this.mScaleY);
            }
            if (this.isEquivalent(this.mSkewX, this.mSkewY))
            {
                this.mRotation = this.mSkewX;
                var _loc_2:* = 0;
                this.mSkewY = 0;
                this.mSkewX = _loc_2;
            }
            else
            {
                this.mRotation = 0;
            }
            return;
        }// end function

        public function get useHandCursor() : Boolean
        {
            return this.mUseHandCursor;
        }// end function

        public function set useHandCursor(param1:Boolean) : void
        {
            if (param1 == this.mUseHandCursor)
            {
                return;
            }
            this.mUseHandCursor = param1;
            if (this.mUseHandCursor)
            {
                this.addEventListener(TouchEvent.TOUCH, this.onTouch);
            }
            else
            {
                this.removeEventListener(TouchEvent.TOUCH, this.onTouch);
            }
            return;
        }// end function

        private function onTouch(event:TouchEvent) : void
        {
            Mouse.cursor = event.interactsWith(this) ? (MouseCursor.BUTTON) : (MouseCursor.AUTO);
            return;
        }// end function

        public function get bounds() : Rectangle
        {
            return this.getBounds(this.mParent);
        }// end function

        public function get width() : Number
        {
            return this.getBounds(this.mParent, sHelperRect).width;
        }// end function

        public function set width(param1:Number) : void
        {
            this.scaleX = 1;
            var _loc_2:* = this.width;
            if (_loc_2 != 0)
            {
                this.scaleX = param1 / _loc_2;
            }
            return;
        }// end function

        public function get height() : Number
        {
            return this.getBounds(this.mParent, sHelperRect).height;
        }// end function

        public function set height(param1:Number) : void
        {
            this.scaleY = 1;
            var _loc_2:* = this.height;
            if (_loc_2 != 0)
            {
                this.scaleY = param1 / _loc_2;
            }
            return;
        }// end function

        public function get x() : Number
        {
            return this.mX;
        }// end function

        public function set x(param1:Number) : void
        {
            if (this.mX != param1)
            {
                this.mX = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get y() : Number
        {
            return this.mY;
        }// end function

        public function set y(param1:Number) : void
        {
            if (this.mY != param1)
            {
                this.mY = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get pivotX() : Number
        {
            return this.mPivotX;
        }// end function

        public function set pivotX(param1:Number) : void
        {
            if (this.mPivotX != param1)
            {
                this.mPivotX = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get pivotY() : Number
        {
            return this.mPivotY;
        }// end function

        public function set pivotY(param1:Number) : void
        {
            if (this.mPivotY != param1)
            {
                this.mPivotY = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get scaleX() : Number
        {
            return this.mScaleX;
        }// end function

        public function set scaleX(param1:Number) : void
        {
            if (this.mScaleX != param1)
            {
                this.mScaleX = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get scaleY() : Number
        {
            return this.mScaleY;
        }// end function

        public function set scaleY(param1:Number) : void
        {
            if (this.mScaleY != param1)
            {
                this.mScaleY = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get skewX() : Number
        {
            return this.mSkewX;
        }// end function

        public function set skewX(param1:Number) : void
        {
            param1 = this.normalizeAngle(param1);
            if (this.mSkewX != param1)
            {
                this.mSkewX = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get skewY() : Number
        {
            return this.mSkewY;
        }// end function

        public function set skewY(param1:Number) : void
        {
            param1 = this.normalizeAngle(param1);
            if (this.mSkewY != param1)
            {
                this.mSkewY = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get rotation() : Number
        {
            return this.mRotation;
        }// end function

        public function set rotation(param1:Number) : void
        {
            param1 = this.normalizeAngle(param1);
            if (this.mRotation != param1)
            {
                this.mRotation = param1;
                this.mOrientationChanged = true;
            }
            return;
        }// end function

        public function get alpha() : Number
        {
            return this.mAlpha;
        }// end function

        public function set alpha(param1:Number) : void
        {
            this.mAlpha = param1 < 0 ? (0) : (param1 > 1 ? (1) : (param1));
            return;
        }// end function

        public function get visible() : Boolean
        {
            return this.mVisible;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this.mVisible = param1;
            return;
        }// end function

        public function get touchable() : Boolean
        {
            return this.mTouchable;
        }// end function

        public function set touchable(param1:Boolean) : void
        {
            this.mTouchable = param1;
            return;
        }// end function

        public function get blendMode() : String
        {
            return this.mBlendMode;
        }// end function

        public function set blendMode(param1:String) : void
        {
            this.mBlendMode = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this.mName;
        }// end function

        public function set name(param1:String) : void
        {
            this.mName = param1;
            return;
        }// end function

        public function get filter() : FragmentFilter
        {
            return this.mFilter;
        }// end function

        public function set filter(param1:FragmentFilter) : void
        {
            this.mFilter = param1;
            return;
        }// end function

        public function get parent() : DisplayObjectContainer
        {
            return this.mParent;
        }// end function

        public function get base() : DisplayObject
        {
            var _loc_1:* = this;
            while (_loc_1.mParent)
            {
                
                _loc_1 = _loc_1.mParent;
            }
            return _loc_1;
        }// end function

        public function get root() : DisplayObject
        {
            var _loc_1:* = this;
            while (_loc_1.mParent)
            {
                
                if (_loc_1.mParent is Stage)
                {
                    return _loc_1;
                }
                _loc_1 = _loc_1.parent;
            }
            return null;
        }// end function

        public function get stage() : Stage
        {
            return this.base as Stage;
        }// end function

    }
}
