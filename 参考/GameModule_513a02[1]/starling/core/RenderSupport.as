package starling.core
{
    import __AS3__.vec.*;
    import com.adobe.utils.*;
    import flash.display3D.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.textures.*;
    import starling.utils.*;

    public class RenderSupport extends Object
    {
        private var mProjectionMatrix:Matrix;
        private var mModelViewMatrix:Matrix;
        private var mMvpMatrix:Matrix;
        private var mMvpMatrix3D:Matrix3D;
        private var mMatrixStack:Vector.<Matrix>;
        private var mMatrixStackSize:int;
        private var mDrawCount:int;
        private var mBlendMode:String;
        private var mRenderTarget:Texture;
        private var mClipRectStack:Vector.<Rectangle>;
        private var mClipRectStackSize:int;
        private var mQuadBatches:Vector.<QuadBatch>;
        private var mCurrentQuadBatchID:int;
        private static var sPoint:Point = new Point();
        private static var sRectangle:Rectangle = new Rectangle();
        private static var sAssembler:AGALMiniAssembler = new AGALMiniAssembler();

        public function RenderSupport()
        {
            this.mProjectionMatrix = new Matrix();
            this.mModelViewMatrix = new Matrix();
            this.mMvpMatrix = new Matrix();
            this.mMvpMatrix3D = new Matrix3D();
            this.mMatrixStack = new Vector.<Matrix>(0);
            this.mMatrixStackSize = 0;
            this.mDrawCount = 0;
            this.mRenderTarget = null;
            this.mBlendMode = BlendMode.NORMAL;
            this.mClipRectStack = new Vector.<Rectangle>(0);
            this.mCurrentQuadBatchID = 0;
            new Vector.<QuadBatch>(1)[0] = new QuadBatch();
            this.mQuadBatches = new Vector.<QuadBatch>(1);
            this.loadIdentity();
            this.setOrthographicProjection(0, 0, 400, 300);
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.mQuadBatches)
            {
                
                _loc_1.dispose();
            }
            return;
        }// end function

        public function setOrthographicProjection(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.mProjectionMatrix.setTo(2 / param3, 0, 0, -2 / param4, (-(2 * param1 + param3)) / param3, (2 * param2 + param4) / param4);
            this.applyClipRect();
            return;
        }// end function

        public function loadIdentity() : void
        {
            this.mModelViewMatrix.identity();
            return;
        }// end function

        public function translateMatrix(param1:Number, param2:Number) : void
        {
            MatrixUtil.prependTranslation(this.mModelViewMatrix, param1, param2);
            return;
        }// end function

        public function rotateMatrix(param1:Number) : void
        {
            MatrixUtil.prependRotation(this.mModelViewMatrix, param1);
            return;
        }// end function

        public function scaleMatrix(param1:Number, param2:Number) : void
        {
            MatrixUtil.prependScale(this.mModelViewMatrix, param1, param2);
            return;
        }// end function

        public function prependMatrix(param1:Matrix) : void
        {
            MatrixUtil.prependMatrix(this.mModelViewMatrix, param1);
            return;
        }// end function

        public function transformMatrix(param1:DisplayObject) : void
        {
            MatrixUtil.prependMatrix(this.mModelViewMatrix, param1.transformationMatrix);
            return;
        }// end function

        public function pushMatrix() : void
        {
            if (this.mMatrixStack.length < (this.mMatrixStackSize + 1))
            {
                this.mMatrixStack.push(new Matrix());
            }
            var _loc_1:* = this;
            _loc_1.mMatrixStackSize = this.mMatrixStackSize + 1;
            this.mMatrixStack[int(this.mMatrixStackSize++)].copyFrom(this.mModelViewMatrix);
            return;
        }// end function

        public function popMatrix() : void
        {
            var _loc_1:* = this;
            this.mMatrixStackSize = (this.mMatrixStackSize - 1);
            _loc_1.mMatrixStackSize = this.mMatrixStackSize - 1;
            this.mModelViewMatrix.copyFrom(this.mMatrixStack[int(this.mMatrixStackSize)]);
            return;
        }// end function

        public function resetMatrix() : void
        {
            this.mMatrixStackSize = 0;
            this.loadIdentity();
            return;
        }// end function

        public function get mvpMatrix() : Matrix
        {
            this.mMvpMatrix.copyFrom(this.mModelViewMatrix);
            this.mMvpMatrix.concat(this.mProjectionMatrix);
            return this.mMvpMatrix;
        }// end function

        public function get mvpMatrix3D() : Matrix3D
        {
            return MatrixUtil.convertTo3D(this.mvpMatrix, this.mMvpMatrix3D);
        }// end function

        public function get modelViewMatrix() : Matrix
        {
            return this.mModelViewMatrix;
        }// end function

        public function get projectionMatrix() : Matrix
        {
            return this.mProjectionMatrix;
        }// end function

        public function set projectionMatrix(param1:Matrix) : void
        {
            this.mProjectionMatrix.copyFrom(param1);
            this.applyClipRect();
            return;
        }// end function

        public function applyBlendMode(param1:Boolean) : void
        {
            setBlendFactors(param1, this.mBlendMode);
            return;
        }// end function

        public function get blendMode() : String
        {
            return this.mBlendMode;
        }// end function

        public function set blendMode(param1:String) : void
        {
            if (param1 != BlendMode.AUTO)
            {
                this.mBlendMode = param1;
            }
            return;
        }// end function

        public function get renderTarget() : Texture
        {
            return this.mRenderTarget;
        }// end function

        public function set renderTarget(param1:Texture) : void
        {
            this.mRenderTarget = param1;
            this.applyClipRect();
            if (param1)
            {
                Starling.context.setRenderToTexture(param1.base);
            }
            else
            {
                Starling.context.setRenderToBackBuffer();
            }
            return;
        }// end function

        public function pushClipRect(param1:Rectangle) : Rectangle
        {
            if (this.mClipRectStack.length < (this.mClipRectStackSize + 1))
            {
                this.mClipRectStack.push(new Rectangle());
            }
            this.mClipRectStack[this.mClipRectStackSize].copyFrom(param1);
            param1 = this.mClipRectStack[this.mClipRectStackSize];
            if (this.mClipRectStackSize > 0)
            {
                RectangleUtil.intersect(param1, this.mClipRectStack[(this.mClipRectStackSize - 1)], param1);
            }
            var _loc_2:* = this;
            var _loc_3:* = this.mClipRectStackSize + 1;
            _loc_2.mClipRectStackSize = _loc_3;
            this.applyClipRect();
            return param1;
        }// end function

        public function popClipRect() : void
        {
            if (this.mClipRectStackSize > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.mClipRectStackSize - 1;
                _loc_1.mClipRectStackSize = _loc_2;
                this.applyClipRect();
            }
            return;
        }// end function

        public function applyClipRect() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this.finishQuadBatch();
            var _loc_1:* = Starling.context;
            if (_loc_1 == null)
            {
                return;
            }
            if (this.mClipRectStackSize > 0)
            {
                _loc_4 = this.mClipRectStack[(this.mClipRectStackSize - 1)];
                sRectangle.setTo(_loc_4.x, _loc_4.y, _loc_4.width, _loc_4.height);
                if (this.mRenderTarget)
                {
                    _loc_2 = this.mRenderTarget.root.nativeWidth;
                    _loc_3 = this.mRenderTarget.root.nativeHeight;
                }
                else
                {
                    _loc_2 = Starling.current.backBufferWidth;
                    _loc_3 = Starling.current.backBufferHeight;
                }
                MatrixUtil.transformCoords(this.mProjectionMatrix, _loc_4.x, _loc_4.y, sPoint);
                sRectangle.x = sPoint.x > -1 ? ((sPoint.x + 1) / 2 * _loc_2) : (0);
                sRectangle.y = sPoint.y > -1 ? ((-sPoint.y + 1) / 2 * _loc_3) : (0);
                MatrixUtil.transformCoords(this.mProjectionMatrix, _loc_4.right, _loc_4.bottom, sPoint);
                sRectangle.right = sPoint.x < 1 ? ((sPoint.x + 1) / 2 * _loc_2) : (_loc_2);
                sRectangle.bottom = sPoint.y < 1 ? ((-sPoint.y + 1) / 2 * _loc_3) : (_loc_3);
                if (sRectangle.right < 1 || sRectangle.bottom < 1)
                {
                    sRectangle.setTo(0, 0, 1, 1);
                }
                _loc_1.setScissorRectangle(sRectangle);
            }
            else
            {
                _loc_1.setScissorRectangle(null);
            }
            return;
        }// end function

        public function batchQuad(param1:Quad, param2:Number, param3:Texture = null, param4:String = null) : void
        {
            if (this.mQuadBatches[this.mCurrentQuadBatchID].isStateChange(param1.tinted, param2, param3, param4, this.mBlendMode))
            {
                this.finishQuadBatch();
            }
            this.mQuadBatches[this.mCurrentQuadBatchID].addQuad(param1, param2, param3, param4, this.mModelViewMatrix, this.mBlendMode);
            return;
        }// end function

        public function batchQuadBatch(param1:QuadBatch, param2:Number) : void
        {
            if (this.mQuadBatches[this.mCurrentQuadBatchID].isStateChange(param1.tinted, param2, param1.texture, param1.smoothing, this.mBlendMode))
            {
                this.finishQuadBatch();
            }
            this.mQuadBatches[this.mCurrentQuadBatchID].addQuadBatch(param1, param2, this.mModelViewMatrix, this.mBlendMode);
            return;
        }// end function

        public function finishQuadBatch() : void
        {
            var _loc_1:* = this.mQuadBatches[this.mCurrentQuadBatchID];
            if (_loc_1.numQuads != 0)
            {
                _loc_1.renderCustom(this.mProjectionMatrix);
                _loc_1.reset();
                var _loc_2:* = this;
                var _loc_3:* = this.mCurrentQuadBatchID + 1;
                _loc_2.mCurrentQuadBatchID = _loc_3;
                var _loc_2:* = this;
                var _loc_3:* = this.mDrawCount + 1;
                _loc_2.mDrawCount = _loc_3;
                if (this.mQuadBatches.length <= this.mCurrentQuadBatchID)
                {
                    this.mQuadBatches.push(new QuadBatch());
                }
            }
            return;
        }// end function

        public function nextFrame() : void
        {
            this.resetMatrix();
            this.trimQuadBatches();
            this.mCurrentQuadBatchID = 0;
            this.mBlendMode = BlendMode.NORMAL;
            this.mDrawCount = 0;
            return;
        }// end function

        private function trimQuadBatches() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = this.mCurrentQuadBatchID + 1;
            var _loc_2:* = this.mQuadBatches.length;
            if (_loc_2 >= 16 && _loc_2 > 2 * _loc_1)
            {
                _loc_3 = _loc_2 - _loc_1;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    this.mQuadBatches.pop().dispose();
                    _loc_4++;
                }
            }
            return;
        }// end function

        public function clear(param1:uint = 0, param2:Number = 0) : void
        {
            RenderSupport.clear(param1, param2);
            return;
        }// end function

        public function raiseDrawCount(param1:uint = 1) : void
        {
            this.mDrawCount = this.mDrawCount + param1;
            return;
        }// end function

        public function get drawCount() : int
        {
            return this.mDrawCount;
        }// end function

        public static function transformMatrixForObject(param1:Matrix, param2:DisplayObject) : void
        {
            MatrixUtil.prependMatrix(param1, param2.transformationMatrix);
            return;
        }// end function

        public static function setDefaultBlendFactors(param1:Boolean) : void
        {
            setBlendFactors(param1);
            return;
        }// end function

        public static function setBlendFactors(param1:Boolean, param2:String = "normal") : void
        {
            var _loc_3:* = BlendMode.getBlendFactors(param2, param1);
            Starling.context.setBlendFactors(_loc_3[0], _loc_3[1]);
            return;
        }// end function

        public static function clear(param1:uint = 0, param2:Number = 0) : void
        {
            Starling.context.clear(Color.getRed(param1) / 255, Color.getGreen(param1) / 255, Color.getBlue(param1) / 255, param2);
            return;
        }// end function

        public static function assembleAgal(param1:String, param2:String, param3:Program3D = null) : Program3D
        {
            var _loc_4:* = null;
            if (param3 == null)
            {
                _loc_4 = Starling.context;
                if (_loc_4 == null)
                {
                    throw new MissingContextError();
                }
                param3 = _loc_4.createProgram();
            }
            param3.upload(sAssembler.assemble(Context3DProgramType.VERTEX, param1), sAssembler.assemble(Context3DProgramType.FRAGMENT, param2));
            return param3;
        }// end function

        public static function getTextureLookupFlags(param1:String, param2:Boolean, param3:Boolean = false, param4:String = "bilinear") : String
        {
            var _loc_5:* = ["2d", param3 ? ("repeat") : ("clamp")];
            if (param1 == Context3DTextureFormat.COMPRESSED)
            {
                _loc_5.push("dxt1");
            }
            else if (param1 == "compressedAlpha")
            {
                _loc_5.push("dxt5");
            }
            if (param4 == TextureSmoothing.NONE)
            {
                _loc_5.push("nearest", param2 ? ("mipnearest") : ("mipnone"));
            }
            else if (param4 == TextureSmoothing.BILINEAR)
            {
                _loc_5.push("linear", param2 ? ("mipnearest") : ("mipnone"));
            }
            else
            {
                _loc_5.push("linear", param2 ? ("miplinear") : ("mipnone"));
            }
            return "<" + _loc_5.join() + ">";
        }// end function

    }
}
