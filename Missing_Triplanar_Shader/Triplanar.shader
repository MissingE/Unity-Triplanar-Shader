Shader "Missing/Triplanar"
{
    Properties
    {
       _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
       
        CGPROGRAM
        
        #pragma surface surf Standard

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
            float3 worldNormal;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
           
            float2 topUV = float2(IN.worldPos.x, IN.worldPos.z);
            float2 frontUV = float2(IN.worldPos.x, IN.worldPos.y);
            float2 sideUV = float2(IN.worldPos.z, IN.worldPos.y);

            float4 topTex = tex2D(_MainTex, topUV);
            float4 frontTex = tex2D(_MainTex, frontUV);
            float4 sideTex = tex2D(_MainTex, sideUV);

            o.Albedo = lerp(topTex, frontTex, abs(IN.worldNormal.z));
            o.Albedo = lerp(o.Albedo, sideTex, abs(IN.worldNormal.x));
            o.Alpha = 1;

           
        }
        ENDCG
    }
    FallBack "Diffuse"
}
