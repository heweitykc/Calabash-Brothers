package starling.filters
{
    import __AS3__.vec.*;
    import flash.display3D.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.display.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.textures.*;
    import starling.utils.*;

    public class FragmentFilter extends Object
    {
        private const MIN_TEXTURE_SIZE:int = 64;
        protected const PMA:Boolean = true;
        protected const STD_VERTEX_SHADER:String;
        protected const STD_FRAGMENT_SHADER:String = "tex oc, v0, fs0 <2d, clamp, linear, mipnone>";
        private var mVertexPosAtID:int = 0;
        private var mTexCoordsAtID:int = 1;
        private var mBaseTextureID:int = 0;
        private var mMvpConstantID:int = 0;
        private var mNumPasses:int;
        private var mPassTextures:Vector.<Texture>;
        private var mMode:String;
        private var mResolution:Number;
        private var mMarginX:Number;
        private var mMarginY:Number;
        private var mOffsetX:Number;
        private var mOffsetY:Number;
        private var mVertexData:VertexData;
        private var mVertexBuffer:VertexBuffer3D;
        private var mIndexData:Vector.<uint>;
        private var mIndexBuffer:IndexBuffer3D;
        private var mCacheRequested:Boolean;
        private var mCache:QuadBatch;
        private var mProjMatrix:Matrix;
        private static var sBounds:Rectangle = new Rectangle();
        private static var sBoundsPot:Rectangle = new Rectangle();
        private static var sStageBounds:Rectangle = new Rectangle();
        private static var sTransformationMatrix:Matrix = new Matrix();

        public function FragmentFilter(param1:int = 1, param2:Number = 1)
        {
            this.STD_VERTEX_SHADER = "m44 op, va0, vc0 \n" + "mov v0, va1      \n";
            this.mProjMatrix = new Matrix();
            if (Capabilities.isDebugger && getQualifiedClassName(this) == "starling.filters::FragmentFilter")
            {
                throw new AbstractClassError();
            }
            if (param1 < 1)
            {
                throw new ArgumentError("At least one pass is required.");
            }
            this.mNumPasses = param1;
            var _loc_3:* = 0;
            this.mMarginY = 0;
            this.mMarginX = _loc_3;
            var _loc_3:* = 0;
            this.mOffsetY = 0;
            this.mOffsetX = _loc_3;
            this.mResolution = param2;
            this.mMode = FragmentFilterMode.REPLACE;
            this.mVertexData = new VertexData(4);
            this.mVertexData.setTexCoords(0, 0, 0);
            this.mVertexData.setTexCoords(1, 1, 0);
            this.mVertexData.setTexCoords(2, 0, 1);
            this.mVertexData.setTexCoords(3, 1, 1);
            new Vector.<uint>(6)[0] = 0;
            new Vector.<uint>(6)[1] = 1;
            new Vector.<uint>(6)[2] = 2;
            new Vector.<uint>(6)[3] = 1;
            new Vector.<uint>(6)[4] = 3;
            new Vector.<uint>(6)[5] = 2;
            this.mIndexData = new Vector.<uint>(6);
            this.mIndexData.fixed = true;
            this.createPrograms();
            Starling.current.stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated, false, 0, true);
            return;
        }// end function

        public function dispose() : void
        {
            Starling.current.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (this.mVertexBuffer)
            {
                this.mVertexBuffer.dispose();
            }
            if (this.mIndexBuffer)
            {
                this.mIndexBuffer.dispose();
            }
            this.disposePassTextures();
            this.disposeCache();
            return;
        }// end function

        private function onContextCreated(param1:Object) : void
        {
            this.mVertexBuffer = null;
            this.mIndexBuffer = null;
            this.mPassTextures = null;
            this.createPrograms();
            return;
        }// end function

        public function render(param1:DisplayObject, param2:RenderSupport, param3:Number) : void
        {
            if (this.mode == FragmentFilterMode.ABOVE)
            {
                param1.render(param2, param3);
            }
            if (this.mCacheRequested)
            {
                this.mCacheRequested = false;
                this.mCache = this.renderPasses(param1, param2, 1, true);
                this.disposePassTextures();
            }
            if (this.mCache)
            {
                this.mCache.render(param2, param3);
            }
            else
            {
                this.renderPasses(param1, param2, param3, false);
            }
            if (this.mode == FragmentFilterMode.BELOW)
            {
                param1.render(param2, param3);
            }
            return;
        }// end function

        private function renderPasses(param1:DisplayObject, param2:RenderSupport, param3:Number, param4:Boolean = false) : QuadBatch
        {
            var _loc_5:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_6:* = null;
            var _loc_7:* = param1.stage;
            var _loc_8:* = Starling.context;
            var _loc_9:* = Starling.current.contentScaleFactor;
            if (_loc_7 == null)
            {
                throw new Error("Filtered object must be on the stage.");
            }
            if (_loc_8 == null)
            {
                throw new MissingContextError();
            }
            this.calculateBounds(param1, _loc_7, this.mResolution * _loc_9, !param4, sBounds, sBoundsPot);
            if (sBounds.isEmpty())
            {
                this.disposePassTextures();
                return param4 ? (new QuadBatch()) : (null);
            }
            this.updateBuffers(_loc_8, sBoundsPot);
            this.updatePassTextures(sBoundsPot.width, sBoundsPot.height, this.mResolution * _loc_9);
            param2.finishQuadBatch();
            param2.raiseDrawCount(this.mNumPasses);
            param2.pushMatrix();
            this.mProjMatrix.copyFrom(param2.projectionMatrix);
            var _loc_10:* = param2.renderTarget;
            if (param2.renderTarget)
            {
                throw new IllegalOperationError("It\'s currently not possible to stack filters! " + "This limitation will be removed in a future Stage3D version.");
            }
            if (param4)
            {
                _loc_6 = Texture.empty(sBoundsPot.width, sBoundsPot.height, this.PMA, false, true, this.mResolution * _loc_9);
            }
            param2.renderTarget = this.mPassTextures[0];
            param2.clear();
            param2.blendMode = BlendMode.NORMAL;
            param2.setOrthographicProjection(sBounds.x, sBounds.y, sBoundsPot.width, sBoundsPot.height);
            param1.render(param2, param3);
            param2.finishQuadBatch();
            RenderSupport.setBlendFactors(this.PMA);
            param2.loadIdentity();
            param2.pushClipRect(sBounds);
            _loc_8.setVertexBufferAt(this.mVertexPosAtID, this.mVertexBuffer, VertexData.POSITION_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
            _loc_8.setVertexBufferAt(this.mTexCoordsAtID, this.mVertexBuffer, VertexData.TEXCOORD_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
            var _loc_11:* = 0;
            while (_loc_11 < this.mNumPasses)
            {
                
                if (_loc_11 < (this.mNumPasses - 1))
                {
                    param2.renderTarget = this.getPassTexture((_loc_11 + 1));
                    param2.clear();
                }
                else if (param4)
                {
                    param2.renderTarget = _loc_6;
                    param2.clear();
                }
                else
                {
                    param2.projectionMatrix = this.mProjMatrix;
                    param2.renderTarget = _loc_10;
                    param2.translateMatrix(this.mOffsetX, this.mOffsetY);
                    param2.blendMode = param1.blendMode;
                    param2.applyBlendMode(this.PMA);
                }
                _loc_5 = this.getPassTexture(_loc_11);
                _loc_8.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, this.mMvpConstantID, param2.mvpMatrix3D, true);
                _loc_8.setTextureAt(this.mBaseTextureID, _loc_5.base);
                this.activate(_loc_11, _loc_8, _loc_5);
                _loc_8.drawTriangles(this.mIndexBuffer, 0, 2);
                this.deactivate(_loc_11, _loc_8, _loc_5);
                _loc_11++;
            }
            _loc_8.setVertexBufferAt(this.mVertexPosAtID, null);
            _loc_8.setVertexBufferAt(this.mTexCoordsAtID, null);
            _loc_8.setTextureAt(this.mBaseTextureID, null);
            param2.popMatrix();
            param2.popClipRect();
            if (param4)
            {
                param2.renderTarget = _loc_10;
                param2.projectionMatrix.copyFrom(this.mProjMatrix);
                _loc_12 = new QuadBatch();
                _loc_13 = new Image(_loc_6);
                _loc_7.getTransformationMatrix(param1, sTransformationMatrix);
                MatrixUtil.prependTranslation(sTransformationMatrix, sBounds.x + this.mOffsetX, sBounds.y + this.mOffsetY);
                _loc_12.addImage(_loc_13, 1, sTransformationMatrix);
                return _loc_12;
            }
            return null;
        }// end function

        private function updateBuffers(param1:Context3D, param2:Rectangle) : void
        {
            this.mVertexData.setPosition(0, param2.x, param2.y);
            this.mVertexData.setPosition(1, param2.right, param2.y);
            this.mVertexData.setPosition(2, param2.x, param2.bottom);
            this.mVertexData.setPosition(3, param2.right, param2.bottom);
            if (this.mVertexBuffer == null)
            {
                this.mVertexBuffer = param1.createVertexBuffer(4, VertexData.ELEMENTS_PER_VERTEX);
                this.mIndexBuffer = param1.createIndexBuffer(6);
                this.mIndexBuffer.uploadFromVector(this.mIndexData, 0, 6);
            }
            this.mVertexBuffer.uploadFromVector(this.mVertexData.rawData, 0, 4);
            return;
        }// end function

        private function updatePassTextures(param1:int, param2:int, param3:Number) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_4:* = this.mNumPasses > 1 ? (2) : (1);
            var _loc_5:* = this.mPassTextures == null || this.mPassTextures.length != _loc_4 || this.mPassTextures[0].width != param1 || this.mPassTextures[0].height != param2;
            if (this.mPassTextures == null || this.mPassTextures.length != _loc_4 || this.mPassTextures[0].width != param1 || this.mPassTextures[0].height != param2)
            {
                if (this.mPassTextures)
                {
                    for each (_loc_7 in this.mPassTextures)
                    {
                        
                        _loc_7.dispose();
                    }
                    _loc_9.length = _loc_4;
                }
                else
                {
                    this.mPassTextures = new Vector.<Texture>(_loc_4);
                }
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_9[_loc_6] = Texture.empty(param1, param2, this.PMA, false, true, param3);
                    _loc_6++;
                }
            }
            return;
        }// end function

        private function getPassTexture(param1:int) : Texture
        {
            return this.mPassTextures[param1 % 2];
        }// end function

        private function calculateBounds(param1:DisplayObject, param2:Stage, param3:Number, param4:Boolean, param5:Rectangle, param6:Rectangle) : void
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (param1 == param2 || param1 == Starling.current.root)
            {
                var _loc_12:* = 0;
                _loc_8 = 0;
                _loc_7 = _loc_12;
                param5.setTo(0, 0, param2.stageWidth, param2.stageHeight);
            }
            else
            {
                _loc_7 = this.mMarginX;
                _loc_8 = this.mMarginY;
                param1.getBounds(param2, param5);
            }
            if (param4)
            {
                sStageBounds.setTo(0, 0, param2.stageWidth, param2.stageHeight);
                RectangleUtil.intersect(param5, sStageBounds, param5);
            }
            if (!param5.isEmpty())
            {
                param5.inflate(_loc_7, _loc_8);
                _loc_9 = this.MIN_TEXTURE_SIZE / param3;
                _loc_10 = param5.width > _loc_9 ? (param5.width) : (_loc_9);
                _loc_11 = param5.height > _loc_9 ? (param5.height) : (_loc_9);
                param6.setTo(param5.x, param5.y, getNextPowerOfTwo(_loc_10 * param3) / param3, getNextPowerOfTwo(_loc_11 * param3) / param3);
            }
            return;
        }// end function

        private function disposePassTextures() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.mPassTextures)
            {
                
                _loc_1.dispose();
            }
            this.mPassTextures = null;
            return;
        }// end function

        private function disposeCache() : void
        {
            if (this.mCache)
            {
                if (this.mCache.texture)
                {
                    this.mCache.texture.dispose();
                }
                this.mCache.dispose();
                this.mCache = null;
            }
            return;
        }// end function

        protected function createPrograms() : void
        {
            throw new Error("Method has to be implemented in subclass!");
        }// end function

        protected function activate(param1:int, param2:Context3D, param3:Texture) : void
        {
            throw new Error("Method has to be implemented in subclass!");
        }// end function

        protected function deactivate(param1:int, param2:Context3D, param3:Texture) : void
        {
            return;
        }// end function

        protected function assembleAgal(param1:String = null, param2:String = null) : Program3D
        {
            if (param1 == null)
            {
                param1 = this.STD_FRAGMENT_SHADER;
            }
            if (param2 == null)
            {
                param2 = this.STD_VERTEX_SHADER;
            }
            return RenderSupport.assembleAgal(param2, param1);
        }// end function

        public function cache() : void
        {
            this.mCacheRequested = true;
            this.disposeCache();
            return;
        }// end function

        public function clearCache() : void
        {
            this.mCacheRequested = false;
            this.disposeCache();
            return;
        }// end function

        function compile(param1:DisplayObject) : QuadBatch
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.mCache)
            {
                return this.mCache;
            }
            _loc_3 = param1.stage;
            if (_loc_3 == null)
            {
                throw new Error("Filtered object must be on the stage.");
            }
            _loc_2 = new RenderSupport();
            param1.getTransformationMatrix(_loc_3, _loc_2.modelViewMatrix);
            return this.renderPasses(param1, _loc_2, 1, true);
        }// end function

        public function get isCached() : Boolean
        {
            return this.mCache != null || this.mCacheRequested;
        }// end function

        public function get resolution() : Number
        {
            return this.mResolution;
        }// end function

        public function set resolution(param1:Number) : void
        {
            if (param1 <= 0)
            {
                throw new ArgumentError("Resolution must be > 0");
            }
            this.mResolution = param1;
            return;
        }// end function

        public function get mode() : String
        {
            return this.mMode;
        }// end function

        public function set mode(param1:String) : void
        {
            this.mMode = param1;
            return;
        }// end function

        public function get offsetX() : Number
        {
            return this.mOffsetX;
        }// end function

        public function set offsetX(param1:Number) : void
        {
            this.mOffsetX = param1;
            return;
        }// end function

        public function get offsetY() : Number
        {
            return this.mOffsetY;
        }// end function

        public function set offsetY(param1:Number) : void
        {
            this.mOffsetY = param1;
            return;
        }// end function

        protected function get marginX() : Number
        {
            return this.mMarginX;
        }// end function

        protected function set marginX(param1:Number) : void
        {
            this.mMarginX = param1;
            return;
        }// end function

        protected function get marginY() : Number
        {
            return this.mMarginY;
        }// end function

        protected function set marginY(param1:Number) : void
        {
            this.mMarginY = param1;
            return;
        }// end function

        protected function set numPasses(param1:int) : void
        {
            this.mNumPasses = param1;
            return;
        }// end function

        protected function get numPasses() : int
        {
            return this.mNumPasses;
        }// end function

        final protected function get vertexPosAtID() : int
        {
            return this.mVertexPosAtID;
        }// end function

        final protected function set vertexPosAtID(param1:int) : void
        {
            this.mVertexPosAtID = param1;
            return;
        }// end function

        final protected function get texCoordsAtID() : int
        {
            return this.mTexCoordsAtID;
        }// end function

        final protected function set texCoordsAtID(param1:int) : void
        {
            this.mTexCoordsAtID = param1;
            return;
        }// end function

        final protected function get baseTextureID() : int
        {
            return this.mBaseTextureID;
        }// end function

        final protected function set baseTextureID(param1:int) : void
        {
            this.mBaseTextureID = param1;
            return;
        }// end function

        final protected function get mvpConstantID() : int
        {
            return this.mMvpConstantID;
        }// end function

        final protected function set mvpConstantID(param1:int) : void
        {
            this.mMvpConstantID = param1;
            return;
        }// end function

    }
}
