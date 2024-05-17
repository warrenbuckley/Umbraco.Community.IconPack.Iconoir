import { ManifestIcons } from "@umbraco-cms/backoffice/extension-registry";

const iconPack: ManifestIcons = {
    type: 'icons',
    name: '[Iconpack] Iconoir',
    alias: 'IconPack.Iconoir',
    js: () => import('./icons.js'),
}
export const manifests = [iconPack];