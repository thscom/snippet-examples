import { create } from "zustand";
import { z } from "zod";

export const GlobalStateSchema = z.object({
  isOpen: z.boolean(),
  open: z.function().returns(z.void()),
  close: z.function().returns(z.void()),
});

export type GlobalState = z.infer<typeof GlobalStateSchema>;

export const useGlobalStore = create<GlobalState>((set) => ({
  isOpen: false,
  open: () => set({ isOpen: true }),
  close: () => set({ isOpen: false }),
}));
