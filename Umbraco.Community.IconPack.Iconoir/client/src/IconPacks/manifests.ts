const iconPack: UmbExtensionManifest = {
    type: 'icons',
    name: '[Iconpack] Iconoir',
    alias: 'IconPack.Iconoir',
    js: () => import('./icons.js'),
}
export const manifests = [iconPack];