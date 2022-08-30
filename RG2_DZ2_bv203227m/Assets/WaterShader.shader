Shader "Custom/WaterShader"
{
    Properties
    {
        // _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (37, 150, 190)
        _Freq("Frequency", Range(0, 5)) = 3
        _Speed("Speed", Range(0, 100)) = 10
        _Amp("Amplitude", Range(0, 1)) = 0.5
        _WaterRenderTexture ("Render Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            // // Physically based Standard lighting model, and enable shadows on all light types
            // #pragma surface surf Standard fullforwardshadows
            #pragma vertex vert
            #pragma fragment frag
            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            // sampler2D _MainTex;
            fixed4 _Color;
            float _Freq;
            float _Speed;
            float _Amp;
            uniform sampler2D _WaterRenderTexture;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                // float3 vertexPosInObjSpace : TEXCOORD1;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            // // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
            // // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
            // // #pragma instancing_options assumeuniformscaling
            // UNITY_INSTANCING_BUFFER_START(Props)
            //     // put more per-instance properties here
            // UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert(appdata v)
            {
                v2f o;

                // default for vertex
                // o.vertex = UnityObjectToClipPos(v.vertex);
                // using sine and time for vertex
                float t = _Time * _Speed;
                float height = sin(t + v.vertex.x * _Freq) * _Amp;
                v.vertex.y += height;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // using render texture for vertex

                
                // o.vertexPosInObjSpace = v.vertex;
                o.normal = v.normal;
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // fixed4 col = tex2D(_WaterRenderTexture, i.uv);
                // col *= _Color;
                fixed4 col = _Color;
                return col;
            }

            ENDCG
        }
    }
}
