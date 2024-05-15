import { defineConfig } from "vite";

export default defineConfig({
    build: {
        lib: {
            entry: "src/index.ts", // Entrypoint file (registers other manifests)
            formats: ["es"],
            fileName: "iconpack-iconoir",
        },
        outDir: "../wwwroot/App_Plugins/Umbraco.IconPack.Iconoir", // your web component will be saved in this location
        emptyOutDir: true,
        sourcemap: true,
        rollupOptions: {
            external: [/^@umbraco/],
        },
    },
});